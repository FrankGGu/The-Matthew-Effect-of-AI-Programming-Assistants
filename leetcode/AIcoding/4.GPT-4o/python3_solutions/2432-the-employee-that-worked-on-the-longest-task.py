from collections import defaultdict

def hardestWorker(n: int, logs: List[List[int]]) -> int:
    max_time = 0
    employee_time = defaultdict(int)

    for i in range(len(logs)):
        employee_id, start_time = logs[i]
        if i == 0:
            duration = start_time
        else:
            duration = start_time - logs[i - 1][1]
        employee_time[employee_id] += duration
        max_time = max(max_time, employee_time[employee_id])

    hardest_worker = min([emp for emp, time in employee_time.items() if time == max_time])

    return hardest_worker