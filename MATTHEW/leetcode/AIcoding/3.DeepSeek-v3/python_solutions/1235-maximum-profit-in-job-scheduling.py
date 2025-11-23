import bisect

class Solution:
    def jobScheduling(self, startTime: List[int], endTime: List[int], profit: List[int]) -> int:
        jobs = sorted(zip(startTime, endTime, profit), key=lambda x: x[1])
        dp_end = [0]
        dp_profit = [0]

        for start, end, p in jobs:
            i = bisect.bisect_right(dp_end, start) - 1
            current_profit = dp_profit[i] + p
            if current_profit > dp_profit[-1]:
                dp_end.append(end)
                dp_profit.append(current_profit)

        return dp_profit[-1]