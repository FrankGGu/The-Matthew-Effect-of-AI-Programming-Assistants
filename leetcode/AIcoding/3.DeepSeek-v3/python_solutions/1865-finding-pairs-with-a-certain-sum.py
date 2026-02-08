class FindSumPairs:

    def __init__(self, nums1: List[int], nums2: List[int]):
        self.nums1 = nums1
        self.nums2 = nums2
        self.count = collections.defaultdict(int)
        for num in nums2:
            self.count[num] += 1

    def add(self, index: int, val: int) -> None:
        old_val = self.nums2[index]
        self.count[old_val] -= 1
        new_val = old_val + val
        self.nums2[index] = new_val
        self.count[new_val] += 1

    def count(self, tot: int) -> int:
        res = 0
        for num in self.nums1:
            res += self.count[tot - num]
        return res