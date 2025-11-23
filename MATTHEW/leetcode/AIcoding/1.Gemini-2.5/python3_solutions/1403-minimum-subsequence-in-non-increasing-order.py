class Solution:
    def minSubsequence(self, nums: list[int]) -> list[int]:
        nums.sort(reverse=True)

        total_sum = sum(nums)
        current_subsequence_sum = 0
        result_subsequence = []

        for num in nums:
            current_subsequence_sum += num
            result_subsequence.append(num)
            remaining_sum = total_sum - current_subsequence_sum

            if current_subsequence_sum > remaining_sum:
                return result_subsequence

        return [] # Should not be reached based on problem constraints (guaranteed unique solution)