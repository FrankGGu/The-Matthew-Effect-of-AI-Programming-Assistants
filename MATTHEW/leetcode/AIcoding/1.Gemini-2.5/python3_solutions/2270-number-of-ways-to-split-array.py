class Solution:
    def waysToSplitArray(self, nums: list[int]) -> int:
        n = len(nums)
        total_sum = sum(nums)

        count = 0
        current_prefix_sum = 0

        # The split point 'i' means the left part is nums[0...i]
        # and the right part is nums[i+1...n-1].
        # 'i' can range from 0 to n-2.
        # If i = n-1, the right part would be empty, which is not allowed
        # as the problem statement implies a non-empty right part (nums[i+1] + ...).
        # Thus, i+1 must be a valid index, so i+1 <= n-1, which means i <= n-2.
        for i in range(n - 1): 
            current_prefix_sum += nums[i]
            left_sum = current_prefix_sum
            right_sum = total_sum - left_sum

            if left_sum >= right_sum:
                count += 1

        return count