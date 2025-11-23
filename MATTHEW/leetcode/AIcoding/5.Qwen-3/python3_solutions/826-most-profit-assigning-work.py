class Solution:
    def maxProfitAssignment(self, difficulty: List[int], profit: List[int], worker: List[int]) -> int:
        jobs = sorted(zip(difficulty, profit))
        worker.sort()
        max_profit = 0
        current_max = 0
        j = 0
        for w in worker:
            while j < len(jobs) and jobs[j][0] <= w:
                current_max = max(current_max, jobs[j][1])
                j += 1
            max_profit += current_max
        return max_profit