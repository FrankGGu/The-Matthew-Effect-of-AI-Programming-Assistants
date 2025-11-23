class Solution:
    def minSubsequence(self, nums: List[int]) -> List[int]:
        nums.sort(reverse=True)
        total_sum = sum(nums)
        current_sum = 0
        result = []
        for num in nums:
            result.append(num)
            current_sum += num
            total_sum -= num
            if current_sum > total_sum:
                return result
        return result