from collections import defaultdict
import bisect

class MajorityChecker:
    def __init__(self, nums):
        self.nums = nums
        self.index_map = defaultdict(list)
        for i, num in enumerate(nums):
            self.index_map[num].append(i)

    def query(self, left, right, threshold):
        nums = self.nums
        candidates = set([nums[left], nums[right]])
        for num in candidates:
            indices = self.index_map[num]
            l = bisect.bisect_left(indices, left)
            r = bisect.bisect_right(indices, right)
            if r - l >= threshold:
                return num
        return -1