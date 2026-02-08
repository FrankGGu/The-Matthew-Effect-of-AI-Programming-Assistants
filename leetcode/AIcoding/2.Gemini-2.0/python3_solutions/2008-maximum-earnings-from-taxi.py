class Solution:
    def maxTaxiEarnings(self, n: int, rides: list[list[int]]) -> int:
        rides.sort()
        dp = [0] * (len(rides) + 1)

        for i in range(1, len(rides) + 1):
            start, end, tip = rides[i-1]
            earnings = end - start + tip

            l, r = 0, i - 1
            prev_ride_index = 0

            while l <= r:
                mid = (l + r) // 2
                if rides[mid-1][1] <= start:
                    prev_ride_index = mid
                    l = mid + 1
                else:
                    r = mid - 1

            dp[i] = max(dp[i-1], dp[prev_ride_index] + earnings)

        return dp[len(rides)]