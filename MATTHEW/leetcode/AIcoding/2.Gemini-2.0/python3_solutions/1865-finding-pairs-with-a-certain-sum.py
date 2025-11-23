from collections import defaultdict

class FindSumPairs:

    def __init__(self, nums1: list[int], nums2: list[int]):
        self.nums1 = nums1
        self.nums2 = nums2
        self.count = defaultdict(int)
        for num in nums2:
            self.count[num] += 1

    def add(self, index: int, val: int) -> None:
        self.count[self.nums2[index]] -= 1
        self.nums2[index] += val
        self.count[self.nums2[index]] += 1

    def count_(self, tot: int) -> int:
        res = 0
        for num in self.nums1:
            res += self.count[tot - num]
        return res