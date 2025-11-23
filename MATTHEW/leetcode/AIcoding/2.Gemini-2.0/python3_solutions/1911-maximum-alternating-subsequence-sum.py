class Solution:
    def maxAlternatingSum(self, nums: List[int]) -> int:
        even = 0
        odd = 0
        for num in nums:
            even_new = max(even, odd + num)
            odd_new = max(odd, even - num)
            even = even_new
            odd = odd_new
        return even