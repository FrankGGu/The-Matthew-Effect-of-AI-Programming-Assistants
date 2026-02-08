class Solution:
    def minSumOfLengths(self, arr: List[int], target: int) -> int:
        prefix = {0: -1}
        curr_sum = 0
        min_len = float('inf')
        dp = [float('inf')] * len(arr)
        res = float('inf')

        for i in range(len(arr)):
            curr_sum += arr[i]
            prefix[curr_sum] = i
            if curr_sum - target in prefix:
                prev = prefix[curr_sum - target]
                length = i - prev
                if prev >= 0 and dp[prev] != float('inf'):
                    res = min(res, length + dp[prev])
                min_len = min(min_len, length)
            dp[i] = min_len

        return res if res != float('inf') else -1