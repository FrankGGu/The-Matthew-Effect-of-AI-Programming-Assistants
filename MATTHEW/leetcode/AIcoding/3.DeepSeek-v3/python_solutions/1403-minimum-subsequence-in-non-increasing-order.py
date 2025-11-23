class Solution:
    def minSubsequence(self, nums: List[int]) -> List[int]:
        nums.sort(reverse=True)
        total_sum = sum(nums)
        current_sum = 0
        result = []
        for num in nums:
            current_sum += num
            result.append(num)
            if current_sum > total_sum - current_sum:
                break
        return result