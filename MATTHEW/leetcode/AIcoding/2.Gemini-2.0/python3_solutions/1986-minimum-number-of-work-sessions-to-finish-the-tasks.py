class Solution:
    def minSessions(self, tasks: List[int], sessionTime: int) -> int:
        n = len(tasks)
        ans = n

        for mask in range(1 << n):
            curr_session = 0
            sessions = 1
            curr_tasks = []

            for i in range(n):
                if (mask >> i) & 1:
                    curr_tasks.append(i)

            if not curr_tasks:
                continue

            curr_session = 0
            for task_idx in curr_tasks:
                if curr_session + tasks[task_idx] <= sessionTime:
                    curr_session += tasks[task_idx]
                else:
                    sessions += 1
                    curr_session = tasks[task_idx]

            remaining_tasks = []
            for i in range(n):
                if not ((mask >> i) & 1):
                    remaining_tasks.append(i)

            if not remaining_tasks:
                ans = min(ans, sessions)
                continue

            dp = {}

            def solve(remaining_mask, curr_time):
                if remaining_mask == 0:
                    return 1 if curr_time > 0 else 0

                if (remaining_mask, curr_time) in dp:
                    return dp[(remaining_mask, curr_time)]

                min_sessions = float('inf')
                for i in range(len(remaining_tasks)):
                    if (remaining_mask >> i) & 1:
                        if curr_time + tasks[remaining_tasks[i]] <= sessionTime:
                            min_sessions = min(min_sessions, solve(remaining_mask ^ (1 << i), curr_time + tasks[remaining_tasks[i]]))
                        else:
                            min_sessions = min(min_sessions, 1 + solve(remaining_mask ^ (1 << i), tasks[remaining_tasks[i]]))
                dp[(remaining_mask, curr_time)] = min_sessions
                return min_sessions

            remaining_mask = (1 << len(remaining_tasks)) - 1
            ans = min(ans, sessions + solve(remaining_mask, 0))

        return ans