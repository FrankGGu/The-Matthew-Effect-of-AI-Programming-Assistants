import bisect

class Solution:
    def minOperations(self, nums: list[int], queries: list[int]) -> list[int]:
        n = len(nums)
        nums.sort()

        prefix_sums = [0] * (n + 1)
        for i in range(n):
            prefix_sums[i+1] = prefix_sums[i] + nums[i]

        results = []
        for q in queries:
            idx = bisect.bisect_right(nums, q)

            # Operations for elements nums[0...idx-1] (which are <= q)
            # These elements need to be incremented to q.
            # Sum of operations = sum(q - num) for num in nums[0...idx-1]
            #                   = idx * q - sum(nums[0...idx-1])
            left_sum_count = idx
            left_sum_val = prefix_sums[idx]
            ops_left = left_sum_count * q - left_sum_val

            # Operations for elements nums[idx...n-1] (which are > q)
            # These elements need to be decremented to q.
            # Sum of operations = sum(num - q) for num in nums[idx...n-1]
            #                   = sum(nums[idx...n-1]) - (n - idx) * q
            right_sum_count = n - idx
            right_sum_val = prefix_sums[n] - prefix_sums[idx]
            ops_right = right_sum_val - right_sum_count * q

            total_ops = ops_left + ops_right
            results.append(total_ops)

        return results