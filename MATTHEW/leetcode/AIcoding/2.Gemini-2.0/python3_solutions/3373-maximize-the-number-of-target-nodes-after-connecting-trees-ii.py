from collections import defaultdict

class Solution:
    def maximizeTheNumberOfTargetNodes(self, edges: list[list[int]], targetNodes: list[int]) -> int:
        n = len(edges) + 1
        graph = defaultdict(list)
        in_degree = [0] * n
        is_target = [False] * n
        for node in targetNodes:
            is_target[node] = True

        for u, v in edges:
            graph[u].append(v)
            in_degree[v] += 1

        q = []
        for i in range(n):
            if in_degree[i] == 0:
                q.append(i)

        ans = 0

        while q:
            u = q.pop(0)

            if is_target[u]:
                ans += 1
            else:
                if not graph[u]:
                    continue

                max_target_child = -1
                for v in graph[u]:
                    if max_target_child == -1 or is_target[v]:
                        max_target_child = v

                if max_target_child != -1:
                    is_target[u] = True
                    ans += 1

            for v in graph[u]:
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        return ans