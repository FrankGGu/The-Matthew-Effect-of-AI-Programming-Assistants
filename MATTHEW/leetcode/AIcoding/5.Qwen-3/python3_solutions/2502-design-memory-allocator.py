class Allocator:
    def __init__(self, n: int):
        self.n = n
        self.memory = [0] * n

    def allocate(self, size: int, mID: int) -> int:
        start = -1
        for i in range(self.n):
            if self.memory[i] == 0:
                if start == -1:
                    start = i
                if i - start + 1 == size:
                    for j in range(start, i + 1):
                        self.memory[j] = mID
                    return start
            else:
                start = -1
        return -1

    def free(self, mID: int) -> int:
        count = 0
        for i in range(self.n):
            if self.memory[i] == mID:
                self.memory[i] = 0
                count += 1
        return count