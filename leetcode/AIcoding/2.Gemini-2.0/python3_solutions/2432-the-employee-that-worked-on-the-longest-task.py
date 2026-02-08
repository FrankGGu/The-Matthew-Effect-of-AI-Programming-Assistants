class Solution:
    def hardestWorker(self, n: int, logs: List[List[int]]) -> int:
        max_duration = logs[0][1]
        hardest_worker = logs[0][0]
        prev_time = logs[0][1]

        for i in range(1, len(logs)):
            duration = logs[i][1] - prev_time
            if duration > max_duration:
                max_duration = duration
                hardest_worker = logs[i][0]
            elif duration == max_duration:
                hardest_worker = min(hardest_worker, logs[i][0])
            prev_time = logs[i][1]

        return hardest_worker