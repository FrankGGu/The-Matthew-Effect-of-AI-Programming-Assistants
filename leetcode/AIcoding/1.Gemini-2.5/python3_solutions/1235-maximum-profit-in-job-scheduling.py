class Solution:
    def jobScheduling(self, startTime: list[int], endTime: list[int], profit: list[int]) -> int:
        n = len(startTime)
        if n == 0:
            return 0

        jobs = []
        for i in range(n):
            jobs.append((startTime[i], endTime[i], profit[i]))

        jobs.sort(key=lambda x: x[1])

        dp = [0] * n

        dp[0] = jobs[0][2]

        for i in range(1, n):
            current_start_time, current_end_time, current_profit = jobs[i]

            profit_without_current = dp[i-1]

            low, high = 0, i - 1
            prev_job_idx = -1
            while low <= high:
                mid = (low + high) // 2
                if jobs[mid][1] <= current_start_time:
                    prev_job_idx = mid
                    low = mid + 1
                else:
                    high = mid - 1

            profit_from_previous_non_overlapping_jobs = 0
            if prev_job_idx != -1:
                profit_from_previous_non_overlapping_jobs = dp[prev_job_idx]

            profit_with_current = current_profit + profit_from_previous_non_overlapping_jobs

            dp[i] = max(profit_without_current, profit_with_current)

        return dp[n-1]