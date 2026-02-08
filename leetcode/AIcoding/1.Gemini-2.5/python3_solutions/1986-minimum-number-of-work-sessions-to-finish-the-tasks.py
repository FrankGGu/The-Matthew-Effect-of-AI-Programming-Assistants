import math

class Solution:
    def minSessions(self, tasks: list[int], sessionTime: int) -> int:
        n = len(tasks)

        # dp[mask] stores a tuple (min_sessions, last_session_remaining_capacity)
        # min_sessions: minimum number of sessions to complete tasks in `mask`
        # last_session_remaining_capacity: the remaining capacity of the last session used
        # We want to minimize min_sessions, and if min_sessions is equal, maximize remaining_capacity.

        # Initialize dp with a value indicating infinity sessions and -1 remaining capacity
        # -1 is chosen to ensure any valid remaining capacity (0 to sessionTime) is better
        dp = [(math.inf, -1)] * (1 << n)

        # Base case: No tasks completed (mask 0).
        # We start with 1 session that is completely empty.
        # This means we are about to start filling the first session.
        dp[0] = (1, sessionTime)

        # Iterate through all possible masks from 0 to (2^n - 1)
        for mask in range(1 << n):
            current_sessions, current_remaining = dp[mask]

            # If this state is unreachable, skip
            if current_sessions == math.inf:
                continue

            # Try to add each unassigned task to the current mask
            for i in range(n):
                # Check if task 'i' is not in the current mask
                if not ((mask >> i) & 1):
                    new_mask = mask | (1 << i)
                    task_cost = tasks[i]

                    # Option 1: Try to add task 'i' to the current (last) session
                    if task_cost <= current_remaining:
                        next_sessions_A = current_sessions
                        next_remaining_A = current_remaining - task_cost
                        candidate_A = (next_sessions_A, next_remaining_A)

                        # Update dp[new_mask] if candidate_A is better
                        if candidate_A[0] < dp[new_mask][0] or \
                           (candidate_A[0] == dp[new_mask][0] and candidate_A[1] > dp[new_mask][1]):
                            dp[new_mask] = candidate_A

                    # Option 2: Start a new session for task 'i'
                    # This implies the current session is finished (or we choose to finish it).
                    # The number of sessions increases by 1. The new session starts with task 'i'.
                    # Problem constraints ensure tasks[i] <= sessionTime.
                    next_sessions_B = current_sessions + 1
                    next_remaining_B = sessionTime - task_cost
                    candidate_B = (next_sessions_B, next_remaining_B)

                    # Update dp[new_mask] if candidate_B is better
                    if candidate_B[0] < dp[new_mask][0] or \
                       (candidate_B[0] == dp[new_mask][0] and candidate_B[1] > dp[new_mask][1]):
                        dp[new_mask] = candidate_B

        # The result is the minimum number of sessions for all tasks (mask = (1 << n) - 1)
        # The remaining capacity doesn't matter for the final answer, only the session count.
        return dp[(1 << n) - 1][0]