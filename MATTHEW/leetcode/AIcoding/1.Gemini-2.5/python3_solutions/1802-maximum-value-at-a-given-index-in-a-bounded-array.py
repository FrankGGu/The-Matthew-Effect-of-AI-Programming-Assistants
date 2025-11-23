class Solution:
    def get_sum(self, peak_val, length):
        if length <= 0:
            return 0

        if peak_val < length:
            # Sequence: peak_val, peak_val-1, ..., 1, 1, ..., 1
            # Sum of arithmetic series 1 to peak_val: peak_val * (peak_val + 1) / 2
            # Plus (length - peak_val) ones
            return (peak_val * (peak_val + 1) // 2) + (length - peak_val)
        else: # peak_val >= length
            # Sequence: peak_val, peak_val-1, ..., peak_val-length+1
            # Sum of arithmetic series: (first + last) * count / 2
            # first = peak_val
            # last = peak_val - length + 1
            return (peak_val + (peak_val - length + 1)) * length // 2

    def maxValue(self, n: int, index: int, maxSum: int) -> int:
        low = 1
        high = maxSum
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2

            current_sum = mid # Value at nums[index]

            # Calculate sum for the left side of index
            left_length = index
            # The value adjacent to nums[index] on the left would be at most mid - 1
            current_sum += self.get_sum(mid - 1, left_length)

            # Calculate sum for the right side of index
            right_length = n - 1 - index
            # The value adjacent to nums[index] on the right would be at most mid - 1
            current_sum += self.get_sum(mid - 1, right_length)

            if current_sum <= maxSum:
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans