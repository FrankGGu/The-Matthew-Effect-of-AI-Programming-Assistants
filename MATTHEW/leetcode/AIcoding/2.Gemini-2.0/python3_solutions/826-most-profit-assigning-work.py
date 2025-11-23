class Solution:
    def maxProfitAssignment(self, difficulty: list[int], profit: list[int], worker: list[int]) -> int:
        jobs = sorted(zip(difficulty, profit))
        worker.sort()
        max_profit = 0
        i = 0
        best_profit = 0
        for skill in worker:
            while i < len(jobs) and skill >= jobs[i][0]:
                best_profit = max(best_profit, jobs[i][1])
                i += 1
            max_profit += best_profit
        return max_profit