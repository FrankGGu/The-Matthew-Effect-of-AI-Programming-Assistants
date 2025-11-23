class Solution:
    def findMaxLength(self, nums: list[int]) -> int:
        max_len = 0
        current_sum = 0
        # A dictionary to store the first occurrence of each prefix sum
        # The key is the prefix sum, the value is the index where it was first encountered
        # {0: -1} handles the case where the longest subarray starts from index 0
        sum_map = {0: -1}

        for i in range(len(nums)):
            # Treat 0s as -1 and 1s as 1
            current_sum += 1 if nums[i] == 1 else -1

            if current_sum in sum_map:
                # If the current_sum has been seen before, it means the subarray
                # between the previous occurrence of this sum and the current index
                # has a sum of 0.
                max_len = max(max_len, i - sum_map[current_sum])
            else:
                # If this is the first time we see this sum, store its index
                sum_map[current_sum] = i

        return max_len