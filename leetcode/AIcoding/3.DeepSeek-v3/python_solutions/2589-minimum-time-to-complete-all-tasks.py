class Solution:
    def findMinimumTime(self, tasks: List[List[int]]) -> int:
        tasks.sort(key=lambda x: x[1])
        used = [False] * (tasks[-1][1] + 1)
        res = 0

        for start, end, duration in tasks:
            overlap = 0
            for t in range(start, end + 1):
                if used[t]:
                    overlap += 1
            remaining = duration - overlap
            if remaining > 0:
                t = end
                while remaining > 0:
                    if not used[t]:
                        used[t] = True
                        remaining -= 1
                        res += 1
                    t -= 1
        return res