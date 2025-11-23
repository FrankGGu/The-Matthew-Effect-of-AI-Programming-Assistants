class Solution:
    def minChanges(self, nums: List[int], n: int) -> int:
        from collections import Counter

        count = Counter()
        for i in range(n):
            count[nums[i]] += 1

        res = 0
        for key in count:
            if count[key] > n // 2:
                res += count[key] - n // 2

        return res