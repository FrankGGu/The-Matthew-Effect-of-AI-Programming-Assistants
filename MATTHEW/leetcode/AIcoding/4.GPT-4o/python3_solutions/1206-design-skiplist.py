import random

class Skiplist:
    def __init__(self):
        self.head = [float('-inf')] * 32
        self.level = 0
        self.size = 0

    def random_level(self):
        level = 0
        while random.random() < 0.5 and level < 31:
            level += 1
        return level

    def search(self, target: int) -> bool:
        current = self.head
        for i in range(self.level, -1, -1):
            while current[i] is not None and current[i][0] < target:
                current = current[i][1]
        current = current[0] if current[0][0] == target else None
        return current is not None

    def add(self, num: int) -> None:
        update = [None] * 32
        current = self.head
        for i in range(self.level, -1, -1):
            while current[i] is not None and current[i][0] < num:
                current = current[i][1]
            update[i] = current

        current = current[0] if current[0][0] == num else None
        if current is None:
            new_level = self.random_level()
            if new_level > self.level:
                for i in range(self.level + 1, new_level + 1):
                    update[i] = self.head
                self.level = new_level

            new_node = [num, None]
            for i in range(new_level + 1):
                new_node[1] = update[i][i + 1]
                update[i][i + 1] = new_node
            self.size += 1

    def erase(self, num: int) -> bool:
        update = [None] * 32
        current = self.head
        for i in range(self.level, -1, -1):
            while current[i] is not None and current[i][0] < num:
                current = current[i][1]
            update[i] = current

        current = current[0] if current[0][0] == num else None
        if current is None:
            return False

        for i in range(self.level + 1):
            if update[i][i + 1] == current:
                update[i][i + 1] = current[1]

        while self.level > 0 and self.head[self.level][1] is None:
            self.level -= 1

        self.size -= 1
        return True