class Node:
    def __init__(self, val=0):
        self.val = val
        self.keys = set()
        self.prev = None
        self.next = None

class AllOne:

    def __init__(self):
        self.head = Node()
        self.tail = Node()
        self.head.next = self.tail
        self.tail.prev = self.head
        self.key_to_node = {}

    def inc(self, key: str) -> None:
        if key not in self.key_to_node:
            current_node = self.head
        else:
            current_node = self.key_to_node[key]
            current_node.keys.remove(key)

        next_node = current_node.next
        if next_node.val != current_node.val + 1:
            new_node = Node(current_node.val + 1)
            self._insert_after(current_node, new_node)
            next_node = new_node

        next_node.keys.add(key)
        self.key_to_node[key] = next_node

        if current_node != self.head and not current_node.keys:
            self._remove_node(current_node)

    def dec(self, key: str) -> None:
        if key not in self.key_to_node:
            return

        current_node = self.key_to_node[key]
        current_node.keys.remove(key)
        del self.key_to_node[key]

        if current_node.val > 1:
            prev_node = current_node.prev
            if prev_node.val != current_node.val - 1:
                new_node = Node(current_node.val - 1)
                self._insert_after(prev_node, new_node)
                prev_node = new_node

            prev_node.keys.add(key)
            self.key_to_node[key] = prev_node

        if not current_node.keys:
            self._remove_node(current_node)

    def getMaxKey(self) -> str:
        if self.tail.prev == self.head:
            return ""
        return next(iter(self.tail.prev.keys))

    def getMinKey(self) -> str:
        if self.head.next == self.tail:
            return ""
        return next(iter(self.head.next.keys))

    def _insert_after(self, node: Node, new_node: Node) -> None:
        new_node.prev = node
        new_node.next = node.next
        node.next.prev = new_node
        node.next = new_node

    def _remove_node(self, node: Node) -> None:
        node.prev.next = node.next
        node.next.prev = node.prev