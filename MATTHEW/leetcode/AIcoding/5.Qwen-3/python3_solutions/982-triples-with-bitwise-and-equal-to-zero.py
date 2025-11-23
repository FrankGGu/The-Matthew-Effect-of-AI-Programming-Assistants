class Solution:
    def numTriplets(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        n = len(nums)

        for i in range(n):
            for j in range(i + 1, n):
                count[nums[i] & nums[j]] += 1

        result = 0
        for k in range(n):
            result += count.get(nums[k], 0)

        return result