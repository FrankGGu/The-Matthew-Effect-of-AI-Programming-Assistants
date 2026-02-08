import collections

class Solution:
    def maximumStrongPairXor(self, nums: list[int]) -> int:
        nums.sort()
        n = len(nums)

        max_xor_result = 0

        # Iterate from the most significant bit (MSB) down to the least significant bit (LSB).
        # The maximum value for nums[i] is 10^9, which is less than 2^30.
        # So, we check bits from 29 (for 2^29) down to 0 (for 2^0).
        for bit_idx in range(29, -1, -1):
            # current_attempt_xor represents the potential maximum XOR value if we can set the current bit_idx to 1.
            # It's formed by taking the max_xor_result found so far and setting the current bit_idx to 1.
            current_attempt_xor = max_xor_result | (1 << bit_idx)

            # prefix_counts will store the frequency of prefixes of numbers within the current sliding window.
            # The prefix for a number `num` at `bit_idx` is `num >> (bit_idx + 1)`.
            prefix_counts = collections.Counter()

            left = 0
            found_pair_for_this_bit = False

            # Iterate with a sliding window [left, right] over the sorted array.
            for right in range(n):
                num_r = nums[right]

                # Adjust the left pointer of the window.
                # The strong pair condition is max(x, y) <= 2 * min(x, y).
                # If x = num_r and y = nums[left], this means num_r <= 2 * nums[left].
                # We remove elements from the left of the window if nums[left] is too small
                # to form a strong pair with num_r.
                while num_r > 2 * nums[left]:
                    prefix_val_to_remove = nums[left] >> (bit_idx + 1)
                    prefix_counts[prefix_val_to_remove] -= 1
                    if prefix_counts[prefix_val_to_remove] == 0:
                        del prefix_counts[prefix_val_to_remove]
                    left += 1

                # Add the current number's prefix to the counts.
                # This ensures `num_r` itself is considered as a potential 'y' for 'x=num_r',
                # as well as other numbers in the window.
                prefix_val_to_add = num_r >> (bit_idx + 1)
                prefix_counts[prefix_val_to_add] += 1

                # Calculate the target prefix we need from a 'y' in the window.
                # If (num_r ^ y) has `current_attempt_xor` as its prefix (up to `bit_idx`),
                # then (num_r >> (bit_idx + 1)) ^ (y >> (bit_idx + 1)) must be equal to
                # (current_attempt_xor >> (bit_idx + 1)).
                # Rearranging for (y >> (bit_idx + 1)):
                # (y >> (bit_idx + 1)) = (num_r >> (bit_idx + 1)) ^ (current_attempt_xor >> (bit_idx + 1))
                target_prefix_for_y = (num_r >> (bit_idx + 1)) ^ (current_attempt_xor >> (bit_idx + 1))

                # Check if such a `target_prefix_for_y` exists in our current window's prefixes.
                if prefix_counts[target_prefix_for_y] > 0:
                    found_pair_for_this_bit = True
                    break # A pair is found that allows this bit to be 1, no need to check further for this bit_idx.

            # If we found a pair that allows this bit to be 1, update max_xor_result.
            if found_pair_for_this_bit:
                max_xor_result = current_attempt_xor

        return max_xor_result