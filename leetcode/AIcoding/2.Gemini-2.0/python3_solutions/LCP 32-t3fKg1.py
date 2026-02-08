class Solution:
    def minimumTime(self, tasks: list[int], workers: list[int]) -> int:
        tasks.sort()
        workers.sort()
        l, r = 0, len(tasks) - 1
        ans = 0
        while l <= r:
            if workers[-1] >= tasks[r]:
                r -= 1
                workers.pop()
            else:
                l += 1
                ans += 1
        return ans