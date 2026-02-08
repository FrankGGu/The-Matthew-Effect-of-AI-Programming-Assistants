class Solution:
    def movesToMakeZigzag(self, nums: List[int]) -> int:
        n = len(nums)
        res1, res2 = 0, 0

        for i in range(n):
            left = nums[i-1] if i > 0 else float('inf')
            right = nums[i+1] if i < n-1 else float('inf')
            min_neighbor = min(left, right)

            if i % 2 == 0:
                if nums[i] >= min_neighbor:
                    res1 += nums[i] - min_neighbor + 1
            else:
                if nums[i] >= min_neighbor:
                    res2 += nums[i] - min_neighbor + 1

        return min(res1, res2)