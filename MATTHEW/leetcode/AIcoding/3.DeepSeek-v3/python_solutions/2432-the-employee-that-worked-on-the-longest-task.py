class Solution:
    def hardestWorker(self, n: int, logs: List[List[int]]) -> int:
        max_time = logs[0][1]
        result = logs[0][0]

        for i in range(1, len(logs)):
            current_time = logs[i][1] - logs[i-1][1]
            if current_time > max_time:
                max_time = current_time
                result = logs[i][0]
            elif current_time == max_time:
                if logs[i][0] < result:
                    result = logs[i][0]

        return result