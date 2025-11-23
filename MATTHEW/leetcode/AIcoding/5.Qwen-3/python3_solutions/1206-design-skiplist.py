class Skiplist:

    def __init__(self):
        self.levels = []

    def search(self, target: int) -> bool:
        node = self.levels[0] if self.levels else None
        while node:
            if node.val == target:
                return True
            elif node.val < target:
                node = node.next
            else:
                break
        return False

    def add(self, num: int) -> None:
        new_node = Node(num)
        if not self.levels:
            self.levels.append(new_node)
            return
        current_level = 0
        while current_level < len(self.levels):
            node = self.levels[current_level]
            prev = None
            while node and node.val < num:
                prev = node
                node = node.next
            if prev:
                new_node.next = prev.next
                prev.next = new_node
            else:
                new_node.next = self.levels[current_level]
                self.levels[current_level] = new_node
            if random.random() < 0.5:
                break
            current_level += 1
        if current_level == len(self.levels):
            self.levels.append(new_node)

    def erase(self, num: int) -> bool:
        removed = False
        for level in range(len(self.levels)):
            node = self.levels[level]
            prev = None
            while node and node.val < num:
                prev = node
                node = node.next
            if node and node.val == num:
                if prev:
                    prev.next = node.next
                else:
                    self.levels[level] = node.next
                removed = True
        return removed

class Node:
    def __init__(self, val):
        self.val = val
        self.next = None