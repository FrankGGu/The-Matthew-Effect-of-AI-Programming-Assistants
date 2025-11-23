class Solution:
    def minimumTime(self, tasks: List[List[int]]) -> int:
        tasks.sort(key=lambda x: x[1])
        current_time = 0

        for t in tasks:
            start, end = t
            if current_time < start:
                current_time = start
            current_time += 1

        return current_time