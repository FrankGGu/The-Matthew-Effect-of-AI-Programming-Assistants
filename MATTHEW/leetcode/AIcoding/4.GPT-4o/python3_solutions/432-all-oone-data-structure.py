class Node:
    def __init__(self, count):
        self.count = count
        self.keys = set()
        self.prev = None
        self.next = None

class AllOne:

    def __init__(self):
        self.key_count = {}
        self.count_node = {}
        self.head = Node(0)
        self.tail = Node(0)
        self.head.next = self.tail
        self.tail.prev = self.head

    def _add_node(self, new_node, prev_node):
        new_node.prev = prev_node
        new_node.next = prev_node.next
        prev_node.next.prev = new_node
        prev_node.next = new_node

    def _remove_node(self, node):
        node.prev.next = node.next
        node.next.prev = node.prev

    def inc(self, key: str) -> None:
        count = self.key_count.get(key, 0)
        self.key_count[key] = count + 1
        new_count = count + 1

        if new_count not in self.count_node:
            new_node = Node(new_count)
            self.count_node[new_count] = new_node
            if count > 0:
                self._add_node(new_node, self.count_node[count])
            else:
                self._add_node(new_node, self.head)

        if count > 0:
            node = self.count_node[count]
            node.keys.remove(key)
            if not node.keys:
                self._remove_node(node)

        self.count_node[new_count].keys.add(key)

    def dec(self, key: str) -> None:
        if key not in self.key_count:
            return
        count = self.key_count[key]
        self.key_count[key] = count - 1
        new_count = count - 1

        node = self.count_node[count]
        node.keys.remove(key)
        if not node.keys:
            self._remove_node(node)
            del self.count_node[count]

        if new_count > 0:
            if new_count not in self.count_node:
                new_node = Node(new_count)
                self.count_node[new_count] = new_node
                self._add_node(new_node, self.count_node[count].prev)
            self.count_node[new_count].keys.add(key)
        else:
            del self.key_count[key]

    def getMaxKey(self) -> str:
        if self.tail.prev == self.head:
            return ""
        return next(iter(self.tail.prev.keys))

    def getMinKey(self) -> str:
        if self.head.next == self.tail:
            return ""
        return next(iter(self.head.next.keys))