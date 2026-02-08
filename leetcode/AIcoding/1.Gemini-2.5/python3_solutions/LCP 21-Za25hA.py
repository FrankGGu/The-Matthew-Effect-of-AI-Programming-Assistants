from collections import deque

class Solution:
    def solve(self, n: int, edges: list[list[int]], startA: int, startB: int) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        distA = [float('inf')] * n
        qA = deque([(startA, 0)])
        distA[startA] = 0
        while qA:
            u, d = qA.popleft()
            for v in adj[u]:
                if distA[v] == float('inf'):
                    distA[v] = d + 1
                    qA.append((v, d + 1))

        distB = [float('inf')] * n
        qB = deque([(startB, 0)])
        distB[startB] = 0
        while qB:
            u, d = qB.popleft()
            for v in adj[u]:
                if distB[v] == float('inf'):
                    distB[v] = d + 1
                    qB.append((v, d + 1))

        if distA[startB] <= distB[startB]:
            return 0

        max_turns = 0

        def dfs(u, parent, current_turns):
            nonlocal max_turns
            max_turns = max(max_turns, current_turns)

            for v in adj[u]:
                if v == parent:
                    continue

                # B can move to v if B can reach v and A cannot intercept v.
                # A cannot intercept v if A takes strictly more time to reach v than B would take from startB.
                # This is equivalent to distA[v] > distB[v].
                # distB[v] must be finite for B to reach v. If distB[v] is inf, the condition distA[v] > inf will be false.
                # If distA[v] is inf, it means A cannot reach v, so inf > distB[v] will be true (assuming distB[v] is finite).
                if distA[v] > distB[v]:
                    dfs(v, u, current_turns + 1)

        dfs(startB, -1, 0)

        return max_turns