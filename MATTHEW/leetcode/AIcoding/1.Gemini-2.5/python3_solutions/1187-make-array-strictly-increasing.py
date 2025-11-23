import collections
import bisect

class Solution:
    def makeArrayIncreasing(self, arr1: list[int], arr2: list[int]) -> int:
        arr2_unique_sorted = sorted(list(set(arr2)))

        # dp[k] stores the minimum possible value of the last element
        # of a strictly increasing prefix of arr1, using k operations (replacements).
        # Initialize with 0 operations, where the "previous" element is -1
        # (a sentinel value smaller than any possible array element).
        dp = {0: -1}

        for num in arr1:
            next_dp = collections.defaultdict(lambda: float('inf'))

            for ops, prev_val in dp.items():
                # Option 1: Don't replace 'num'
                # If 'num' is greater than the previous element (prev_val),
                # we can keep 'num' without any operations.
                if num > prev_val:
                    next_dp[ops] = min(next_dp[ops], num)

                # Option 2: Replace 'num' with an element from arr2_unique_sorted
                # We need to find the smallest element in arr2_unique_sorted
                # that is strictly greater than prev_val.
                # bisect_right returns an insertion point which comes after (to the right of)
                # any existing entries of prev_val. This correctly finds the first element > prev_val.
                idx = bisect.bisect_right(arr2_unique_sorted, prev_val)

                if idx < len(arr2_unique_sorted):
                    replacement_val = arr2_unique_sorted[idx]
                    # If we replace 'num', it costs 1 operation.
                    next_dp[ops + 1] = min(next_dp[ops + 1], replacement_val)

            dp = next_dp

            # If next_dp is empty, it means no valid strictly increasing sequence
            # could be formed up to the current element 'num' for any number of operations.
            # In this case, we can break early as further processing won't yield a solution.
            if not dp:
                break

        min_ops = float('inf')
        for ops in dp.keys():
            if dp[ops] != float('inf'):
                min_ops = min(min_ops, ops)

        return min_ops if min_ops != float('inf') else -1