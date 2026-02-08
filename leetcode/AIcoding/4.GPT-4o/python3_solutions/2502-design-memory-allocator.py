class Allocator:

    def __init__(self, n: int):
        self.size = n
        self.memory = [0] * n

    def allocate(self, size: int, mID: int) -> int:
        if size <= 0:
            return 0
        count = 0
        start = -1
        for i in range(self.size):
            if self.memory[i] == 0:
                if start == -1:
                    start = i
                count += 1
                if count == size:
                    for j in range(start, start + size):
                        self.memory[j] = mID
                    return start
            else:
                start = -1
                count = 0
        return 0

    def free(self, mID: int) -> int:
        count = 0
        for i in range(self.size):
            if self.memory[i] == mID:
                self.memory[i] = 0
                count += 1
        return count