import random

class SkiplistNode:
    def __init__(self, val=None, level=0):
        self.val = val
        self.next = [None] * level

class Skiplist:
    MAX_LEVEL = 16 
    P = 0.5 

    def __init__(self):
        self.head = SkiplistNode(val=-1, level=self.MAX_LEVEL)
        self.level = 1

    def _random_level(self):
        lvl = 1
        while random.random() < self.P and lvl < self.MAX_LEVEL:
            lvl += 1
        return lvl

    def search(self, target: int) -> bool:
        curr = self.head

        for i in range(self.level - 1, -1, -1):
            while curr.next[i] and curr.next[i].val < target:
                curr = curr.next[i]

        curr = curr.next[0]

        return curr is not None and curr.val == target

    def add(self, num: int) -> None:
        update = [None] * self.MAX_LEVEL
        curr = self.head

        for i in range(self.level - 1, -1, -1):
            while curr.next[i] and curr.next[i].val < num:
                curr = curr.next[i]
            update[i] = curr

        new_node_level = self._random_level()

        if new_node_level > self.level:
            for i in range(self.level, new_node_level):
                update[i] = self.head
            self.level = new_node_level

        new_node = SkiplistNode(val=num, level=new_node_level)

        for i in range(new_node_level):
            new_node.next[i] = update[i].next[i]
            update[i].next[i] = new_node

    def erase(self, num: int) -> bool:
        update = [None] * self.MAX_LEVEL
        curr = self.head

        for i in range(self.level - 1, -1, -1):
            while curr.next[i] and curr.next[i].val < num:
                curr = curr.next[i]
            update[i] = curr

        curr = curr.next[0] 

        if curr is None or curr.val != num:
            return False

        for i in range(self.level):
            if update[i].next[i] == curr:
                update[i].next[i] = curr.next[i]

        while self.level > 1 and self.head.next[self.level - 1] is None:
            self.level -= 1

        return True