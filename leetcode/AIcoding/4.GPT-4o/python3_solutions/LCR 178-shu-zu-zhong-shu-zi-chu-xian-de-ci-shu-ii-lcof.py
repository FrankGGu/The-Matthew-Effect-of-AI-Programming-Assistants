class Solution:
    def trainingPlan(self, n: int, difficulty: List[int], profit: List[int], worker: List[int]) -> int:
        dp = [0] * (n + 1)
        jobs = sorted(zip(difficulty, profit), key=lambda x: x[0])

        for w in sorted(worker):
            for i in range(len(jobs) - 1, -1, -1):
                if jobs[i][0] <= w:
                    dp[w] = max(dp[w], dp[w - 1] + jobs[i][1])

        return max(dp)