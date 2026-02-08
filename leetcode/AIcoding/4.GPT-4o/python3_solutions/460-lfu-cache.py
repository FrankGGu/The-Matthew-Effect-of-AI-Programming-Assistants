class Node:
    def __init__(self, key, value):
        self.key = key
        self.value = value
        self.freq = 1
        self.prev = None
        self.next = None

class DoublyLinkedList:
    def __init__(self):
        self.head = Node(0, 0)
        self.tail = Node(0, 0)
        self.head.next = self.tail
        self.tail.prev = self.head
        self.size = 0

    def add_node(self, node):
        node.prev = self.head
        node.next = self.head.next
        self.head.next.prev = node
        self.head.next = node
        self.size += 1

    def remove_node(self, node):
        node.prev.next = node.next
        node.next.prev = node.prev
        self.size -= 1

class LFUCache:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.min_freq = 0
        self.freq_map = {}
        self.key_map = {}

    def _update(self, node):
        freq = node.freq
        self.freq_map[freq].remove_node(node)
        if freq == self.min_freq and self.freq_map[freq].size == 0:
            self.min_freq += 1
        node.freq += 1
        if node.freq not in self.freq_map:
            self.freq_map[node.freq] = DoublyLinkedList()
        self.freq_map[node.freq].add_node(node)

    def get(self, key: int) -> int:
        if key not in self.key_map:
            return -1
        node = self.key_map[key]
        self._update(node)
        return node.value

    def put(self, key: int, value: int) -> None:
        if self.capacity <= 0:
            return
        if key in self.key_map:
            node = self.key_map[key]
            node.value = value
            self._update(node)
        else:
            if len(self.key_map) >= self.capacity:
                lfu_list = self.freq_map[self.min_freq]
                lfu_node = lfu_list.tail.prev
                lfu_list.remove_node(lfu_node)
                del self.key_map[lfu_node.key]
            new_node = Node(key, value)
            self.key_map[key] = new_node
            self.min_freq = 1
            if 1 not in self.freq_map:
                self.freq_map[1] = DoublyLinkedList()
            self.freq_map[1].add_node(new_node)