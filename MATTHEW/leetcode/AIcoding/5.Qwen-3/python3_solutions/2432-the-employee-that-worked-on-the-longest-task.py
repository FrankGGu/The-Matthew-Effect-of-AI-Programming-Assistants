from typing import List

class Solution:
    def hardestWorker(self, n: int, logs: List[List[int]]) = 0
        max_time = 0
        result = 0
        prev_time = 0
        for log in logs:
            employee_id, time = log
            current_time = time - prev_time
            if current_time > max_time:
                max_time = current_time
                result = employee_id
            elif current_time == max_time and employee_id < result:
                result = employee_id
            prev_time = time
        return result