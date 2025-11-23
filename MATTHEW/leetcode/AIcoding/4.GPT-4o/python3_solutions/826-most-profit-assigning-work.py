def maxProfitAssignment(difficulty, profit, worker):
    jobs = sorted(zip(difficulty, profit))
    worker.sort()

    max_profit = 0
    current_profit = 0
    i = 0
    for w in worker:
        while i < len(jobs) and jobs[i][0] <= w:
            current_profit = max(current_profit, jobs[i][1])
            i += 1
        max_profit += current_profit

    return max_profit