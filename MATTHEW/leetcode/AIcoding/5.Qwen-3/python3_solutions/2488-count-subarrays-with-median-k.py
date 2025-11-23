class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        n = len(nums)
        count = defaultdict(int)
        count[0] = 1
        res = 0
        balance = 0

        for num in nums:
            if num < k:
                balance -= 1
            elif num > k:
                balance += 1
            res += count[balance]
            count[balance] += 1

        return res