class Solution:
    def minimumDistance(self, nums: List[int], s: str, d: int) -> int:
        n = len(nums)
        min_dist = float('inf')

        for i in range(n):
            if s[i] == 'L':
                x = nums[i] - d
            else:
                x = nums[i] + d
            dist = abs(x - nums[i])
            min_dist = min(min_dist, dist)

        return min_dist