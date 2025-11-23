class Solution:
    def isSplitPossible(arr):
        from collections import defaultdict

        prefix_sum = 0
        sum_count = defaultdict(int)

        for i in range(len(arr) - 1):
            prefix_sum += arr[i]
            sum_count[prefix_sum] += 1

        for i in range(1, len(arr)):
            if sum_count[arr[i]] > 0:
                return True
            prefix_sum -= arr[i - 1]
            sum_count[prefix_sum] -= 1

        return False