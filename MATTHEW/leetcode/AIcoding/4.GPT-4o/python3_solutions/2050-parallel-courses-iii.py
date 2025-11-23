from collections import defaultdict
import heapq

def minNumberOfSemesters(n: int, relations: List[List[int]], k: int) -> int:
    graph = defaultdict(list)
    indegree = [0] * (n + 1)

    for u, v in relations:
        graph[u].append(v)
        indegree[v] += 1

    dp = [float('inf')] * (1 << n)
    dp[0] = 0

    for mask in range(1 << n):
        count = 0
        available = []

        for i in range(1, n + 1):
            if (mask & (1 << (i - 1))) == 0 and indegree[i] == 0:
                available.append(i)

        for size in range(1, min(len(available), k) + 1):
            for combo in combinations(available, size):
                new_mask = mask
                for course in combo:
                    new_mask |= (1 << (course - 1))
                    for neighbor in graph[course]:
                        indegree[neighbor] -= 1

                dp[new_mask] = min(dp[new_mask], dp[mask] + 1)

                for course in combo:
                    for neighbor in graph[course]:
                        indegree[neighbor] += 1

    return dp[(1 << n) - 1]