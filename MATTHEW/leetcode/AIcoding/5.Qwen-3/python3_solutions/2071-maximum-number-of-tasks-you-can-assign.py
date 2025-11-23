class Solution:
    def maxTasks(self, skills: List[int], tasks: List[int], n: int) -> int:
        from collections import deque

        skills.sort()
        tasks.sort()
        m = len(skills)
        k = len(tasks)
        res = 0
        i = 0
        j = 0
        q = deque()

        while i < m and j < k:
            if skills[i] >= tasks[j]:
                res += 1
                j += 1
                i += 1
                q.append(i - 1)
            else:
                if q and i - q[0] > n:
                    q.popleft()
                else:
                    i += 1

        return res