class Node:
    def __init__(self, count):
        self.count = count
        self.keys = set()
        self.prev = None
        self.next = None

class AllOne:

    def __init__(self):
        self.head = Node(0)
        self.tail = Node(0)
        self.head.next = self.tail
        self.tail.prev = self.head
        self.key_to_node = {}

    def inc(self, key: str) -> None:
        if key in self.key_to_node:
            node = self.key_to_node[key]
            new_count = node.count + 1
            if node.next.count == new_count:
                new_node = node.next
            else:
                new_node = Node(new_count)
                new_node.next = node.next
                new_node.prev = node
                node.next.prev = new_node
                node.next = new_node
            new_node.keys.add(key)
            self.key_to_node[key] = new_node
            node.keys.remove(key)
            if not node.keys:
                node.prev.next = node.next
                node.next.prev = node.prev
        else:
            if self.head.next.count == 1:
                new_node = self.head.next
            else:
                new_node = Node(1)
                new_node.next = self.head.next
                new_node.prev = self.head
                self.head.next.prev = new_node
                self.head.next = new_node
            new_node.keys.add(key)
            self.key_to_node[key] = new_node

    def dec(self, key: str) -> None:
        node = self.key_to_node[key]
        new_count = node.count - 1
        if new_count == 0:
            del self.key_to_node[key]
        else:
            if node.prev.count == new_count:
                new_node = node.prev
            else:
                new_node = Node(new_count)
                new_node.prev = node.prev
                new_node.next = node
                node.prev.next = new_node
                node.prev = new_node
            new_node.keys.add(key)
            self.key_to_node[key] = new_node
        node.keys.remove(key)
        if not node.keys:
            node.prev.next = node.next
            node.next.prev = node.prev

    def getMaxKey(self) -> str:
        if self.tail.prev == self.head:
            return ""
        return next(iter(self.tail.prev.keys))

    def getMinKey(self) -> str:
        if self.head.next == self.tail:
            return ""
        return next(iter(self.head.next.keys))