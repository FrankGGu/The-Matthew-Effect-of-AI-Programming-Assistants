class Solution:
    def exclusiveTime(self, n: int, logs: List[str]) -> List[int]:
        result = [0] * n
        stack = []  # Stores function IDs
        prev_time = 0

        for log_str in logs:
            parts = log_str.split(':')
            fid = int(parts[0])
            event_type = parts[1]
            time = int(parts[2])

            if event_type == "start":
                if stack:
                    # If there's a function currently running, it ran until 'time'
                    result[stack[-1]] += time - prev_time
                stack.append(fid)
                prev_time = time
            else:  # event_type == "end"
                # The function on top of the stack must be 'fid'
                # It ran from 'prev_time' to 'time' (inclusive)
                result[stack[-1]] += time - prev_time + 1
                stack.pop()
                prev_time = time + 1

        return result