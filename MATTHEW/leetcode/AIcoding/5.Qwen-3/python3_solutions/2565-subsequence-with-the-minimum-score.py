class Solution:
    def minSubsequence(self, nums: List[int]) -> List[int]:
        nums.sort(reverse=True)
        total = sum(nums)
        current = 0
        result = []
        for num in nums:
            current += num
            result.append(num)
            if current > total - current:
                break
        return result