class Allocator:

    def __init__(self, n: int):
        self.memory = [0] * n
        self.n = n

    def allocate(self, size: int, mID: int) -> int:
        consecutive = 0
        start = -1
        for i in range(self.n):
            if self.memory[i] == 0:
                consecutive += 1
                if consecutive == size:
                    start = i - size + 1
                    break
            else:
                consecutive = 0
        if start == -1:
            return -1
        for i in range(start, start + size):
            self.memory[i] = mID
        return start

    def free(self, mID: int) -> int:
        count = 0
        for i in range(self.n):
            if self.memory[i] == mID:
                self.memory[i] = 0
                count += 1
        return count