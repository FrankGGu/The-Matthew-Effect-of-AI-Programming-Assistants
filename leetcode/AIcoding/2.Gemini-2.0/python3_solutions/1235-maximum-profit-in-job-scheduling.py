class Solution:
    def jobScheduling(self, startTime: List[int], endTime: List[int], profit: List[int]) -> int:
        jobs = sorted(zip(startTime, endTime, profit), key=lambda x: x[1])
        dp = {}

        def find_max_profit(i):
            if i == len(jobs):
                return 0
            if i in dp:
                return dp[i]

            next_job = i + 1
            while next_job < len(jobs) and jobs[next_job][0] < jobs[i][1]:
                next_job += 1

            dp[i] = max(jobs[i][2] + find_max_profit(next_job), find_max_profit(i + 1))
            return dp[i]

        return find_max_profit(0)