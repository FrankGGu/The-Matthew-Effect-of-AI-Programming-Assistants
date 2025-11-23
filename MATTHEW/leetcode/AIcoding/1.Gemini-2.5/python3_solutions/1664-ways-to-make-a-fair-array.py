class Solution:
    def waysToMakeFair(self, nums: list[int]) -> int:
        n = len(nums)

        left_even_sum = [0] * (n + 1)
        left_odd_sum = [0] * (n + 1)

        for i in range(n):
            left_even_sum[i+1] = left_even_sum[i]
            left_odd_sum[i+1] = left_odd_sum[i]
            if i % 2 == 0:
                left_even_sum[i+1] += nums[i]
            else:
                left_odd_sum[i+1] += nums[i]

        right_even_sum = [0] * (n + 1)
        right_odd_sum = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            right_even_sum[i] = right_even_sum[i+1]
            right_odd_sum[i] = right_odd_sum[i+1]
            if i % 2 == 0:
                right_even_sum[i] += nums[i]
            else:
                right_odd_sum[i] += nums[i]

        count = 0
        for i in range(n):
            # Sum of even-indexed elements in the new array
            # Elements before i (original even indices) + Elements after i (original odd indices, now shifted to even)
            current_even_sum = left_even_sum[i] + right_odd_sum[i+1]

            # Sum of odd-indexed elements in the new array
            # Elements before i (original odd indices) + Elements after i (original even indices, now shifted to odd)
            current_odd_sum = left_odd_sum[i] + right_even_sum[i+1]

            if current_even_sum == current_odd_sum:
                count += 1

        return count