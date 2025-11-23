class MKAverage:

    def __init__(self, m: int, k: int):
        self.m = m
        self.k = k
        self.stream = []

    def addElement(self, num: int) -> None:
        self.stream.append(num)

    def calculateMKAverage(self) -> int:
        if len(self.stream) < self.m:
            return -1

        nums = self.stream[-self.m:]
        nums.sort()

        trimmed = nums[self.k:self.m - self.k]

        if not trimmed:
            return 0

        return sum(trimmed) // len(trimmed)