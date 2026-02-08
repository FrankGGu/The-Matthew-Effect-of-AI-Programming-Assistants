class Solution:
    def maxScore(self, nums: List[int], x: int) -> int:
        n = len(nums)
        even_max = -float('inf')
        odd_max = -float('inf')

        if nums[0] % 2 == 0:
            even_max = nums[0]
            odd_max = -float('inf')
        else:
            odd_max = nums[0]
            even_max = -float('inf')

        for i in range(1, n):
            if nums[i] % 2 == 0:
                even_max = max(even_max + nums[i], odd_max + nums[i] - x)
            else:
                odd_max = max(odd_max + nums[i], even_max + nums[i] - x)

        return max(even_max, odd_max)