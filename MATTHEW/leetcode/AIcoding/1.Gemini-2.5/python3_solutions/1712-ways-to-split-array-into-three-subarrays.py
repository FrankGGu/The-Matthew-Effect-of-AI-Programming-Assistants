import itertools
import bisect

class Solution:
    def waysToSplitArray(self, nums: list[int]) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + nums[i]

        total_ways = 0
        total_sum = prefix_sum[n]

        # i is the index of the last element of the first subarray (left)
        # So left_sum = prefix_sum[i+1]
        # i can range from 0 to n-3 (to ensure mid and right subarrays are non-empty)
        for i in range(n - 2):
            s1 = prefix_sum[i+1]

            # We need to find j such that:
            # 1. s1 <= s2 (sum of mid)
            # 2. s2 <= s3 (sum of right)
            # j is the index of the last element of the second subarray (mid)
            # s2 = prefix_sum[j+1] - s1
            # s3 = total_sum - prefix_sum[j+1]

            # Condition 1: s1 <= prefix_sum[j+1] - s1
            # => 2 * s1 <= prefix_sum[j+1]

            # Condition 2: prefix_sum[j+1] - s1 <= total_sum - prefix_sum[j+1]
            # => 2 * prefix_sum[j+1] <= total_sum + s1
            # => prefix_sum[j+1] <= (total_sum + s1) // 2

            # j must be such that i < j < n - 1
            # So j+1 must be such that i+1 < j+1 < n
            # The range for j+1 (let's call it k) is [i+2, n-1]

            # Find the minimum k = j+1 for Condition 1
            # bisect_left finds the first index k in prefix_sum[lo:hi] such that prefix_sum[k] >= 2 * s1
            # lo = i+2, hi = n (exclusive)
            left_bound_k = bisect.bisect_left(prefix_sum, 2 * s1, lo=i+2, hi=n)

            # Find the maximum k = j+1 for Condition 2
            # bisect_right finds an insertion point idx such that all elements in prefix_sum[lo:idx-1] are <= (total_sum + s1) // 2
            # We want the largest index k such that prefix_sum[k] <= (total_sum + s1) // 2, so we take idx - 1
            right_bound_k = bisect.bisect_right(prefix_sum, (total_sum + s1) // 2, lo=i+2, hi=n) - 1

            # The number of valid j+1 values (which are k) is right_bound_k - left_bound_k + 1
            # Ensure left_bound_k <= right_bound_k
            if left_bound_k <= right_bound_k:
                total_ways += (right_bound_k - left_bound_k + 1)

        return total_ways