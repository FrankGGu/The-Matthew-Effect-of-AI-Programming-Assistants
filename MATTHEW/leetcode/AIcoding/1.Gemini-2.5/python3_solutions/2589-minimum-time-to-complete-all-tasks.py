class Solution:
    def minTime(self, tasks: list[list[int]]) -> int:
        tasks.sort(key=lambda x: x[1])

        on_time = [False] * 1001
        total_time_points_used = 0

        for start, end, duration in tasks:
            current_duration_satisfied = 0
            for t in range(start, end + 1):
                if on_time[t]:
                    current_duration_satisfied += 1

            if current_duration_satisfied >= duration:
                continue

            needed_to_activate = duration - current_duration_satisfied

            for t in range(end, start - 1, -1):
                if needed_to_activate == 0:
                    break
                if not on_time[t]:
                    on_time[t] = True
                    total_time_points_used += 1
                    needed_to_activate -= 1

        return total_time_points_used