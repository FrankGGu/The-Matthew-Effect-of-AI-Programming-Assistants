import collections

class Solution:
    def longestEqualSubarray(self, nums: list[int], k: int) -> int:
        indices = collections.defaultdict(list)
        for i, num in enumerate(nums):
            indices[num].append(i)

        max_len = 0

        for num_val in indices:
            current_indices = indices[num_val]

            left_idx_ptr = 0
            for right_idx_ptr in range(len(current_indices)):
                current_x_count = right_idx_ptr - left_idx_ptr + 1

                window_start_original_idx = current_indices[left_idx_ptr]
                window_end_original_idx = current_indices[right_idx_ptr]

                total_window_length = window_end_original_idx - window_start_original_idx + 1

                other_elements_count = total_window_length - current_x_count

                while other_elements_count > k:
                    left_idx_ptr += 1
                    current_x_count = right_idx_ptr - left_idx_ptr + 1
                    window_start_original_idx = current_indices[left_idx_ptr]
                    total_window_length = window_end_original_idx - window_start_original_idx + 1
                    other_elements_count = total_window_length - current_x_count

                max_len = max(max_len, current_x_count)

        return max_len