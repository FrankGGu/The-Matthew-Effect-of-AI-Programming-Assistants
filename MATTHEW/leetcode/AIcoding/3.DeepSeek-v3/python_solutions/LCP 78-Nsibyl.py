class Solution:
    def maxEnvelopes(self, envelopes: List[List[int]]) -> int:
        if not envelopes:
            return 0

        envelopes.sort(key=lambda x: (x[0], -x[1]))

        dp = []
        for _, h in envelopes:
            left, right = 0, len(dp)
            while left < right:
                mid = (left + right) // 2
                if dp[mid] < h:
                    left = mid + 1
                else:
                    right = mid
            if right == len(dp):
                dp.append(h)
            else:
                dp[right] = h

        return len(dp)