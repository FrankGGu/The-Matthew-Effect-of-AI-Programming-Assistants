from collections import defaultdict

class Solution:
    def waysToPartition(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # Calculate prefix sums
        # prefix_sums[x] stores sum of nums[0]...nums[x-1]
        # prefix_sums[0] = 0
        # prefix_sums[1] = nums[0]
        # ...
        # prefix_sums[n] = sum(nums)
        prefix_sums = [0] * (n + 1)
        current_sum = 0
        for i in range(n):
            current_sum += nums[i]
            prefix_sums[i+1] = current_sum

        total_sum = prefix_sums[n]

        # Initialize counts for prefix sums.
        # left_freq stores counts of prefix_sums[j+1] for j < i (partition point before changed element)
        # right_freq stores counts of prefix_sums[j+1] for j >= i (partition point at or after changed element)
        # A partition point j means nums[0...j] and nums[j+1...n-1].
        # The left sum is prefix_sums[j+1]. Valid j are from 0 to n-2.
        # So valid prefix_sums[j+1] are prefix_sums[1] to prefix_sums[n-1].

        left_freq = defaultdict(int)
        right_freq = defaultdict(int)

        # Initially, all valid partition prefix sums are in right_freq
        for j_plus_1 in range(1, n): # j+1 ranges from 1 to n-1
            right_freq[prefix_sums[j_plus_1]] += 1

        max_partitions = 0

        # Case 0: No change to the array (or changing nums[i] to nums[i])
        if total_sum % 2 == 0:
            max_partitions = right_freq[total_sum // 2]

        # Case 1: Change one element nums[i] to k
        for i in range(n): # i is the index of the element being changed
            old_val = nums[i]

            # Calculate new total sum after changing nums[i] to k
            new_total_sum = total_sum - old_val + k

            # If new_total_sum is odd, no partition into two equal halves is possible
            if new_total_sum % 2 != 0:
                # Move prefix_sums[i+1] from right_freq to left_freq for the next iteration
                # prefix_sums[i+1] corresponds to a partition at index j=i.
                # If i=n-1, then i+1=n. prefix_sums[n] is total_sum, which is not a valid partition sum (j+1 < n).
                # So we only move if prefix_sums[i+1] is a valid partition sum.
                if i + 1 < n: 
                    right_freq[prefix_sums[i+1]] -= 1
                    left_freq[prefix_sums[i+1]] += 1
                continue

            target_half_sum = new_total_sum // 2
            current_partitions_for_i = 0

            # Count partitions where the partition point j is before i (j < i)
            # The left sum is prefix_sums[j+1]. This sum is unaffected by changing nums[i].
            # j+1 ranges from 1 to i. These prefix sums are in left_freq.
            current_partitions_for_i += left_freq[target_half_sum]

            # Count partitions where the partition point j is at or after i (j >= i)
            # The left sum is prefix_sums[j+1] - old_val + k.
            # We need prefix_sums[j+1] - old_val + k == target_half_sum.
            # This means prefix_sums[j+1] == target_half_sum + old_val - k.
            # j+1 ranges from i+1 to n-1. These prefix sums are in right_freq.
            required_original_prefix_sum_for_right = target_half_sum + old_val - k
            current_partitions_for_i += right_freq[required_original_prefix_sum_for_right]

            max_partitions = max(max_partitions, current_partitions_for_i)

            # Move prefix_sums[i+1] from right_freq to left_freq for the next iteration
            # This corresponds to the partition at index j=i.
            if i + 1 < n:
                right_freq[prefix_sums[i+1]] -= 1
                left_freq[prefix_sums[i+1]] += 1

        return max_partitions