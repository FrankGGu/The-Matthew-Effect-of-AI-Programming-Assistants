from collections import defaultdict

class Solution:
    def longestEqualSubarray(self, nums: list[int], k: int) -> int:
        positions = defaultdict(list)
        for i, num in enumerate(nums):
            positions[num].append(i)

        max_len = 0
        for num_val in positions:
            indices = positions[num_val]

            left = 0
            for right in range(len(indices)):
                current_x_count = right - left + 1

                total_elements_in_window = indices[right] - indices[left] + 1

                non_x_count = total_elements_in_window - current_x_count

                while non_x_count > k:
                    left += 1
                    current_x_count = right - left + 1
                    total_elements_in_window = indices[right] - indices[left] + 1
                    non_x_count = total_elements_in_window - current_x_count

                max_len = max(max_len, current_x_count)

        return max_len