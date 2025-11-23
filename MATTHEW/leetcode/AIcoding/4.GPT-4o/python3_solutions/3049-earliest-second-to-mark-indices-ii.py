class Solution:
    def earliestFullMark(self, n: int, marks: List[int]) -> int:
        last_seen = [-1] * n
        earliest_time = float('inf')

        for time, mark in enumerate(marks):
            if last_seen[mark] != -1:
                earliest_time = min(earliest_time, time - last_seen[mark])
            last_seen[mark] = time

        return earliest_time if earliest_time != float('inf') else -1