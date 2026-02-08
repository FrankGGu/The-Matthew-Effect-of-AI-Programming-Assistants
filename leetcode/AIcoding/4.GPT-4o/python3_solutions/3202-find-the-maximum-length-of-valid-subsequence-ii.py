class Solution:
    def findMaximumLength(self, nums: List[int]) -> int:
        count = {0: -1}
        max_len = 0
        curr_sum = 0

        for i, num in enumerate(nums):
            curr_sum += 1 if num == 1 else -1

            if curr_sum in count:
                max_len = max(max_len, i - count[curr_sum])
            else:
                count[curr_sum] = i

        return max_len