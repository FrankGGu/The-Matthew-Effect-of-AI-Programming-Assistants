class Solution:
    def maxAndSum(self, nums: List[int]) -> int:
        from itertools import permutations

        n = len(nums)
        max_and = 0

        for perm in permutations(range(n)):
            current_and = nums[perm[0]]
            for i in range(1, n):
                current_and &= nums[perm[i]]
            max_and = max(max_and, current_and)

        return max_and