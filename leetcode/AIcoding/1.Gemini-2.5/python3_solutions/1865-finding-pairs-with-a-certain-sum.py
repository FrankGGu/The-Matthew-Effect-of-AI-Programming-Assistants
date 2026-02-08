from collections import defaultdict

class FindSumPairs:

    def __init__(self, nums1: list[int], nums2: list[int]):
        self.nums1 = nums1
        self.nums2 = nums2
        self.freq2 = defaultdict(int)
        for num in nums2:
            self.freq2[num] += 1

    def add(self, index: int, val: int) -> None:
        old_val = self.nums2[index]
        self.freq2[old_val] -= 1

        self.nums2[index] += val
        new_val = self.nums2[index]
        self.freq2[new_val] += 1

    def count(self, tot: int) -> int:
        ans = 0
        for num1 in self.nums1:
            target = tot - num1
            ans += self.freq2[target]
        return ans