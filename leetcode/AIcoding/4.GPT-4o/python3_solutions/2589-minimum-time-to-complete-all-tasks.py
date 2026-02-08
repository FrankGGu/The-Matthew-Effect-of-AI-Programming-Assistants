from typing import List

def minTimeToComplete(tasks: List[int], space: int) -> int:
    last_completion = {}
    current_time = 0

    for task in tasks:
        if task in last_completion:
            current_time = max(current_time, last_completion[task] + space + 1)
        last_completion[task] = current_time
        current_time += 1

    return current_time