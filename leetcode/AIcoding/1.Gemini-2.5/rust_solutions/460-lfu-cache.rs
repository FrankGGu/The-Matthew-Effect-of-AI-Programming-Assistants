use std::collections::HashMap;
use std::ptr;

struct Node {
    key: i32,
    prev: *mut Node,
    next: *mut Node,
}

struct DoublyLinkedList {
    head: *mut Node,
    tail: *mut Node,
}

impl DoublyLinkedList {
    fn new() -> Self {
        DoublyLinkedList {
            head: ptr::null_mut(),
            tail: ptr::null_mut(),
        }
    }

    // Add a new node to the tail
    // Returns a raw pointer to the newly created node
    fn push_back(&mut self, key: i32) -> *mut Node {
        let new_node_box = Box::new(Node {
            key,
            prev: ptr::null_mut(),
            next: ptr::null_mut(),
        });
        let new_node_ptr = Box::into_raw(new_node_box);

        if self.tail.is_null() {
            // List is empty
            self.head = new_node_ptr;
            self.tail = new_node_ptr;
        } else {
            unsafe {
                (*self.tail).next = new_node_ptr;
                (*new_node_ptr).prev = self.tail;
                self.tail = new_node_ptr;
            }
        }
        new_node_ptr
    }

    // Remove a node given its pointer
    // This also deallocates the node memory
    unsafe fn remove_node(&mut self, node_ptr: *mut Node) {
        if node_ptr.is_null() {
            return;
        }

        let node = &mut *node_ptr;

        if node.prev.is_null() {
            // This is the head
            self.head = node.next;
        } else {
            (*node.prev).next = node.next;
        }

        if node.next.is_null() {
            // This is the tail
            self.tail = node.prev;
        } else {
            (*node.next).prev = node.prev;
        }

        // Deallocate the node
        let _ = Box::from_raw(node_ptr);
    }

    // Pop the front node (for LFU eviction)
    // Returns the key of the removed node, and deallocates it
    fn pop_front(&mut self) -> Option<i32> {
        if self.head.is_null() {
            return None;
        }

        unsafe {
            let node_ptr = self.head;
            let key = (*node_ptr).key;
            self.remove_node(node_ptr); // This also deallocates
            Some(key)
        }
    }

    fn is_empty(&self) -> bool {
        self.head.is_null()
    }
}

impl Drop for DoublyLinkedList {
    fn drop(&mut self) {
        let mut current = self.head;
        while !current.is_null() {
            unsafe {
                let next = (*current).next;
                let _ = Box::from_raw(current); // Deallocate node
                current = next;
            }
        }
    }
}

struct LFUCache {
    capacity: i32,
    size: i32,
    min_freq: i32,
    // key -> (value, frequency, pointer to node in freq_list)
    cache: HashMap<i32, (i32, i32, *mut Node)>,
    // frequency -> DoublyLinkedList of keys
    freq_lists: HashMap<i32, DoublyLinkedList>,
}

impl LFUCache {
    fn new(capacity: i32) -> Self {
        LFUCache {
            capacity,
            size: 0,
            min_freq: 0, // Will be 1 once first item is added
            cache: HashMap::new(),
            freq_lists: HashMap::new(),
        }
    }

    // Helper to update frequency of an existing key
    // This involves removing the node from its old frequency list
    // and adding a new node to the new frequency list.
    fn update_frequency(&mut self, key: i32, value: i32, old_freq: i32, old_node_ptr: *mut Node) {
        // Remove from old frequency list
        let old_list = self.freq_lists.get_mut(&old_freq).unwrap();
        unsafe {
            old_list.remove_node(old_node_ptr);
        }

        // If old_list becomes empty and it was the min_freq, increment min_freq
        if old_list.is_empty() && old_freq == self.min_freq {
            self.min_freq += 1;
        }

        // Add to new frequency list
        let new_freq = old_freq + 1;
        let new_list = self.freq_lists.entry(new_freq).or_insert_with(DoublyLinkedList::new);
        let new_node_ptr = new_list.push_back(key);

        // Update cache entry with new value, new frequency, and new node pointer
        self.cache.insert(key, (value, new_freq, new_node_ptr));
    }

    fn get(&mut self, key: i32) -> i32 {
        if self.capacity == 0 {
            return -1;
        }

        if let Some(&(value, old_freq, node_ptr)) = self.cache.get(&key) {
            self.update_frequency(key, value, old_freq, node_ptr);
            value
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.capacity == 0 {
            return;
        }

        if let Some(&(_, old_freq, node_ptr)) = self.cache.get(&key) {
            // Key already exists, update value and frequency
            self.update_frequency(key, value, old_freq, node_ptr);
        } else {
            // Key does not exist
            if self.size == self.capacity {
                // Evict LFU item: the LRU item at min_freq
                let list_to_evict = self.freq_lists.get_mut(&self.min_freq).unwrap();
                if let Some(key_to_remove) = list_to_evict.pop_front() {
                    self.cache.remove(&key_to_remove);
                    self.size -= 1;
                }
            }

            // Add new item
            let new_freq = 1;
            let new_list = self.freq_lists.entry(new_freq).or_insert_with(DoublyLinkedList::new);
            let new_node_ptr = new_list.push_back(key);

            self.cache.insert(key, (value, new_freq, new_node_ptr));
            self.min_freq = 1; // A new item always starts with freq 1, making it the new minimum
            self.size += 1;
        }
    }
}