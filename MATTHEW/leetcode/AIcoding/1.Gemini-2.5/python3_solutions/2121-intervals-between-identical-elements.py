from collections import defaultdict

class Solution:
    def getDistances(self, arr: list[int]) -> list[int]:
        val_to_indices = defaultdict(list)
        for i, num in enumerate(arr):
            val_to_indices[num].append(i)

        n = len(arr)
        ans = [0] * n

        for indices in val_to_indices.values():
            if len(indices) <= 1:
                continue

            total_sum_of_indices = sum(indices)

            current_prefix_sum = 0
            for j, current_index in enumerate(indices):
                # Calculate sum of distances from current_index to elements on its left
                # (j * current_index) - (sum of indices to the left)
                sum_left_part = j * current_index - current_prefix_sum

                # Calculate sum of distances from current_index to elements on its right
                # (sum of indices to the right) - ((count of elements to the right) * current_index)
                count_right = len(indices) - 1 - j
                sum_right_indices = total_sum_of_indices - current_prefix_sum - current_index
                sum_right_part = sum_right_indices - count_right * current_index

                ans[current_index] = sum_left_part + sum_right_part

                current_prefix_sum += current_index

        return ans