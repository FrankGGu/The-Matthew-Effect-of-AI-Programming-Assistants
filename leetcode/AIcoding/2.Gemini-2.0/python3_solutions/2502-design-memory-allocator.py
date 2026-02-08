class Allocator:

    def __init__(self, n: int):
        self.memory = [0] * n
        self.size = n

    def allocate(self, size: int, mID: int) -> int:
        count = 0
        start = -1
        for i in range(self.size):
            if self.memory[i] == 0:
                count += 1
                if count == size:
                    start = i - size + 1
                    for j in range(start, i + 1):
                        self.memory[j] = mID
                    return start
            else:
                count = 0
        return -1

    def free(self, mID: int) -> int:
        count = 0
        for i in range(self.size):
            if self.memory[i] == mID:
                self.memory[i] = 0
                count += 1
        return count