class Solution:
    def minSessions(self, tasks: List[int], sessionTime: int) -> int:
        n = len(tasks)
        tasks.sort(reverse=True)
        self.res = float('inf')
        sessions = []

        def backtrack(index):
            if len(sessions) >= self.res:
                return
            if index == n:
                self.res = min(self.res, len(sessions))
                return
            for i in range(len(sessions)):
                if sessions[i] + tasks[index] <= sessionTime:
                    sessions[i] += tasks[index]
                    backtrack(index + 1)
                    sessions[i] -= tasks[index]
            sessions.append(tasks[index])
            backtrack(index + 1)
            sessions.pop()

        backtrack(0)
        return self.res