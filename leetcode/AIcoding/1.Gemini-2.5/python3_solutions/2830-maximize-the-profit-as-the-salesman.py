import bisect

class Solution:
    def maximizeTheProfit(self, n: int, offers: list[list[int]]) -> int:
        offers.sort(key=lambda x: x[1])

        num_offers = len(offers)
        if num_offers == 0:
            return 0

        dp = [0] * num_offers
        dp[0] = offers[0][2]

        def find_prev_non_overlapping_offer_idx(current_offer_start_time, current_offer_idx):
            low, high = 0, current_offer_idx - 1
            ans_idx = -1

            while low <= high:
                mid = (low + high) // 2
                if offers[mid][1] < current_offer_start_time:
                    ans_idx = mid
                    low = mid + 1
                else:
                    high = mid - 1
            return ans_idx

        for i in range(1, num_offers):
            current_start, current_end, current_profit = offers[i]

            profit_without_current = dp[i-1]

            profit_with_current = current_profit
            prev_non_overlapping_idx = find_prev_non_overlapping_offer_idx(current_start, i)

            if prev_non_overlapping_idx != -1:
                profit_with_current += dp[prev_non_overlapping_idx]

            dp[i] = max(profit_without_current, profit_with_current)

        return dp[num_offers - 1]