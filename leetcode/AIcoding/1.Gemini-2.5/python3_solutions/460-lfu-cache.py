import collections

class Node:
    def __init__(self, key, value, freq):
        self.key = key
        self.value = value
        self.freq = freq
        self.prev = None
        self.next = None

class DoublyLinkedList:
    def __init__(self):
        self.head = Node(0, 0, 0) # Dummy head
        self.tail = Node(0, 0, 0) # Dummy tail
        self.head.next = self.tail
        self.tail.prev = self.head
        self.size = 0

    def add_node(self, node):
        node.next = self.head.next
        node.prev = self.head
        self.head.next.prev = node
        self.head.next = node
        self.size += 1

    def remove_node(self, node):
        node.prev.next = node.next
        node.next.prev = node.prev
        self.size -= 1

    def pop_tail(self):
        if self.size == 0:
            return None
        node = self.tail.prev
        self.remove_node(node)
        return node

    def is_empty(self):
        return self.size == 0

class LFUCache:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.size = 0
        self.min_freq = 0
        self.cache = {} # key -> Node
        self.freq_map = collections.defaultdict(DoublyLinkedList) # freq -> DoublyLinkedList

    def _update_freq(self, node: Node):
        old_freq = node.freq
        self.freq_map[old_freq].remove_node(node)

        if self.freq_map[old_freq].is_empty() and old_freq == self.min_freq:
            self.min_freq += 1

        node.freq += 1
        new_freq = node.freq
        self.freq_map[new_freq].add_node(node)

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1

        node = self.cache[key]
        self._update_freq(node)
        return node.value

    def put(self, key: int, value: int) -> None:
        if self.capacity == 0:
            return

        if key in self.cache:
            node = self.cache[key]
            node.value = value
            self._update_freq(node)
        else:
            if self.size == self.capacity:
                lru_node = self.freq_map[self.min_freq].pop_tail()
                del self.cache[lru_node.key]
                self.size -= 1

            new_node = Node(key, value, 1)
            self.freq_map[1].add_node(new_node)
            self.cache[key] = new_node
            self.min_freq = 1 
            self.size += 1