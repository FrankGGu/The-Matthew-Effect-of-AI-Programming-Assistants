import collections

class Solution:
    def maximumGoodSubarraySum(self, nums: list[int], k: int) -> int:
        max_good_sum = -float('inf')

        # min_prefix_for_val stores {value: minimum_prefix_sum_ending_before_value}
        # Specifically, min_prefix_for_val[x] stores min(sum(nums[0...i-1]))
        # for all indices 'i' encountered so far such that nums[i] == x.
        min_prefix_for_val = {}

        # current_prefix_sum represents sum(nums[0...j-1]) when processing nums[j].
        # It's the prefix sum *before* including nums[j].
        current_prefix_sum = 0 

        for j in range(len(nums)):
            num_j = nums[j]

            # Case 1: nums[i] == num_j - k
            target1 = num_j - k
            if target1 in min_prefix_for_val:
                # The sum of subarray nums[i...j] is (sum(nums[0...j])) - (sum(nums[0...i-1]))
                # sum(nums[0...j]) is (current_prefix_sum + num_j)
                # sum(nums[0...i-1]) is min_prefix_for_val[target1]
                current_subarray_sum = current_prefix_sum + num_j - min_prefix_for_val[target1]
                max_good_sum = max(max_good_sum, current_subarray_sum)

            # Case 2: nums[i] == num_j + k
            target2 = num_j + k
            if target2 in min_prefix_for_val:
                # Same logic as above
                current_subarray_sum = current_prefix_sum + num_j - min_prefix_for_val[target2]
                max_good_sum = max(max_good_sum, current_subarray_sum)

            # Update min_prefix_for_val for num_j.
            # We store current_prefix_sum (which is sum(nums[0...j-1]))
            # as a potential prefix sum for num_j. This value will be used
            # if num_j becomes an 'i' for a future 'j''.
            if num_j not in min_prefix_for_val:
                min_prefix_for_val[num_j] = current_prefix_sum
            else:
                min_prefix_for_val[num_j] = min(min_prefix_for_val[num_j], current_prefix_sum)

            # Update current_prefix_sum to include num_j for the next iteration (j+1).
            # After this line, current_prefix_sum will be sum(nums[0...j]).
            current_prefix_sum += num_j

        # If no good subarray was found, max_good_sum remains -float('inf').
        # According to the problem statement, in this case, we should return 0.
        if max_good_sum == -float('inf'):
            return 0
        else:
            return max_good_sum