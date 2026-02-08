class Solution:
    def maxProfitAssignment(self, difficulty: List[int], profit: List[int], worker: List[int]) -> int:
        jobs = sorted(zip(difficulty, profit))
        worker.sort()
        max_profit = 0
        total = 0
        i = 0
        n = len(jobs)

        for ability in worker:
            while i < n and ability >= jobs[i][0]:
                max_profit = max(max_profit, jobs[i][1])
                i += 1
            total += max_profit

        return total