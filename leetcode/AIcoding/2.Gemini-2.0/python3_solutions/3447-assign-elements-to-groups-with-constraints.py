from collections import defaultdict

class Solution:
    def isPossible(self, n: int, m: int, groupSizes: list[int], dependencies: list[list[int]]) -> bool:
        indegree = [0] * (n + 1)
        graph = defaultdict(list)
        for u, v in dependencies:
            graph[u].append(v)
            indegree[v] += 1

        groups = [[] for _ in range(m)]
        for i in range(1, n + 1):
            groups[(i - 1) % m].append(i)

        assignment = [0] * (n + 1)
        q = []
        assigned_count = 0

        for i in range(1, n + 1):
            if indegree[i] == 0:
                q.append(i)

        while q:
            u = q.pop(0)

            best_group = -1
            min_size = float('inf')

            for i in range(m):
                if u in groups[i] and groupSizes[i] > 0:
                    valid = True
                    for neighbor in graph[u]:
                        if assignment[neighbor] == i + 1:
                            valid = False
                            break
                    if valid and groupSizes[i] < min_size:
                        min_size = groupSizes[i]
                        best_group = i

            if best_group == -1:
                return False

            assignment[u] = best_group + 1
            groupSizes[best_group] -= 1
            assigned_count += 1

            for v in graph[u]:
                indegree[v] -= 1
                if indegree[v] == 0:
                    q.append(v)

        return assigned_count == n