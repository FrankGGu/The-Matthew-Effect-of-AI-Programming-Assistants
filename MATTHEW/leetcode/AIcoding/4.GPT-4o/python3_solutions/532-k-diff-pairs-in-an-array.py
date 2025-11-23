class Solution:
    def findPairs(self, nums: List[int], k: int) -> int:
        if k < 0:
            return 0
        num_count = collections.Counter(nums)
        count = 0
        if k == 0:
            for v in num_count.values():
                if v > 1:
                    count += 1
        else:
            for num in num_count:
                if num + k in num_count:
                    count += 1
        return count