import math

class Solution:
    def findBestValue(self, arr: list[int], target: int) -> int:
        def calculate_sum(arr_list: list[int], value: int) -> int:
            current_sum = 0
            for x in arr_list:
                current_sum += min(x, value)
            return current_sum

        left = 0
        right = max(arr) if arr else 0 # Upper bound for value can be max element in arr

        best_diff = float('inf')
        best_value = 0

        while left <= right:
            mid = left + (right - left) // 2
            current_sum = calculate_sum(arr, mid)
            current_diff = abs(current_sum - target)

            if current_diff < best_diff:
                best_diff = current_diff
                best_value = mid
            elif current_diff == best_diff:
                # If differences are equal, choose the smallest value
                best_value = min(best_value, mid)

            if current_sum < target:
                # We need a larger sum, so increase 'value'
                left = mid + 1
            else:
                # We need a smaller or equal sum, so decrease 'value'
                right = mid - 1

        return best_value