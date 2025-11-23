class Solution:
    def minOperations(self, arr: List[int], k: int) -> int:
        from bisect import bisect_left

        def lis(sequence):
            dp = []
            for x in sequence:
                pos = bisect_left(dp, x)
                if pos == len(dp):
                    dp.append(x)
                else:
                    dp[pos] = x
            return len(dp)

        n = len(arr)
        total_ops = 0
        for start in range(k):
            subsequence = [arr[i] for i in range(start, n, k)]
            total_ops += len(subsequence) - lis(subsequence)

        return total_ops