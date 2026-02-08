import bisect

class Solution:
    def minOperations(self, nums: list[int], queries: list[int]) -> list[int]:
        nums.sort()
        n = len(nums)

        prefix_sums = [0] * (n + 1)
        for i in range(n):
            prefix_sums[i+1] = prefix_sums[i] + nums[i]

        results = []
        for q in queries:
            idx = bisect.bisect_right(nums, q)

            # Calculate operations for elements <= q
            # These elements are nums[0]...nums[idx-1]
            # Each operation is q - nums[i]
            # Total: (idx * q) - sum(nums[0]...nums[idx-1])
            # sum(nums[0]...nums[idx-1]) is prefix_sums[idx]
            left_ops = idx * q - prefix_sums[idx]

            # Calculate operations for elements > q
            # These elements are nums[idx]...nums[n-1]
            # Each operation is nums[i] - q
            # Total: sum(nums[idx]...nums[n-1]) - ((n - idx) * q)
            # sum(nums[idx]...nums[n-1]) is prefix_sums[n] - prefix_sums[idx]
            right_ops = (prefix_sums[n] - prefix_sums[idx]) - (n - idx) * q

            results.append(left_ops + right_ops)

        return results