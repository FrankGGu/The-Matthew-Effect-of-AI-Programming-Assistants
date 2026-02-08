import random

class Skiplist:

    def __init__(self):
        self.MAX_LEVEL = 16
        self.P = 0.5
        self.level = 1
        self.head = SkiplistNode(-1, self.MAX_LEVEL)

    def _random_level(self):
        level = 1
        while random.random() < self.P and level < self.MAX_LEVEL:
            level += 1
        return level

    def search(self, target: int) -> bool:
        curr = self.head
        for i in range(self.level - 1, -1, -1):
            while curr.forward[i] and curr.forward[i].val < target:
                curr = curr.forward[i]
        return curr.forward[0] is not None and curr.forward[0].val == target

    def add(self, num: int) -> None:
        update = [None] * self.MAX_LEVEL
        curr = self.head
        for i in range(self.level - 1, -1, -1):
            while curr.forward[i] and curr.forward[i].val < num:
                curr = curr.forward[i]
            update[i] = curr

        level = self._random_level()
        if level > self.level:
            for i in range(self.level, level):
                update[i] = self.head
            self.level = level

        newNode = SkiplistNode(num, level)
        for i in range(level):
            newNode.forward[i] = update[i].forward[i]
            update[i].forward[i] = newNode

    def erase(self, num: int) -> bool:
        update = [None] * self.MAX_LEVEL
        curr = self.head
        for i in range(self.level - 1, -1, -1):
            while curr.forward[i] and curr.forward[i].val < num:
                curr = curr.forward[i]
            update[i] = curr

        if curr.forward[0] is None or curr.forward[0].val != num:
            return False

        nodeToDelete = curr.forward[0]
        for i in range(self.level):
            if update[i].forward[i] != nodeToDelete:
                break
            update[i].forward[i] = nodeToDelete.forward[i]

        while self.level > 1 and self.head.forward[self.level - 1] is None:
            self.level -= 1

        return True

class SkiplistNode:
    def __init__(self, val, level):
        self.val = val
        self.forward = [None] * level