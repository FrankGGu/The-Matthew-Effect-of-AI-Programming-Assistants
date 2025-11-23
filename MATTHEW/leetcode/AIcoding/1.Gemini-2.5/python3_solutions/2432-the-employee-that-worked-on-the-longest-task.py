class Solution:
    def hardestWorker(self, n: int, logs: list[list[int]]) -> int:
        max_duration = logs[0][1]
        result_employee_id = logs[0][0]
        prev_end_time = logs[0][1]

        for i in range(1, len(logs)):
            employee_id = logs[i][0]
            current_end_time = logs[i][1]
            current_duration = current_end_time - prev_end_time

            if current_duration > max_duration:
                max_duration = current_duration
                result_employee_id = employee_id
            elif current_duration == max_duration:
                result_employee_id = min(result_employee_id, employee_id)

            prev_end_time = current_end_time

        return result_employee_id