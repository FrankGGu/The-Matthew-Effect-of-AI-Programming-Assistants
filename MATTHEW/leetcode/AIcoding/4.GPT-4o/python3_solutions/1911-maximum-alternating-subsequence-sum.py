class Solution:
    def maxAlternatingSum(self, nums: List[int]) -> int:
        even_sum = odd_sum = 0
        for num in nums:
            even_sum, odd_sum = max(even_sum, odd_sum + num), max(odd_sum, even_sum - num)
        return even_sum