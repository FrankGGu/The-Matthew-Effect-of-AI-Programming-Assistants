import random

class MajorityChecker:

    def __init__(self, arr: list[int]):
        self.arr = arr
        self.counts = {}
        for num in arr:
            self.counts[num] = self.counts.get(num, 0) + 1

    def query(self, left: int, right: int, threshold: int) -> int:
        for _ in range(20):
            candidate = self.arr[random.randint(left, right)]
            count = 0
            for i in range(left, right + 1):
                if self.arr[i] == candidate:
                    count += 1
            if count >= threshold:
                return candidate
        return -1