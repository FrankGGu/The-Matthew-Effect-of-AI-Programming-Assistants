def exclusiveTime(n: int, logs: List[str]) -> List[int]:
    time = [0] * n
    stack = []
    prev_time = 0

    for log in logs:
        function_id, status, timestamp = log.split(':')
        function_id = int(function_id)
        timestamp = int(timestamp)

        if status == "start":
            if stack:
                time[stack[-1]] += timestamp - prev_time
            stack.append(function_id)
            prev_time = timestamp
        else:
            time[stack.pop()] += timestamp - prev_time + 1
            prev_time = timestamp + 1

    return time