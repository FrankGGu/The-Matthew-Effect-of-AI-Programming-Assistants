import sys
from collections import defaultdict

sys.setrecursionlimit(1 << 25)

class Solution:
    def countPaths(self, n: int, edges: List[List[int]]) -> int:
        is_prime = [True] * (n + 1)
        is_prime[0] = is_prime[1] = False
        for i in range(2, int(n ** 0.5) + 1):
            if is_prime[i]:
                for j in range(i * i, n + 1, i):
                    is_prime[j] = False

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        res = 0

        def dfs(node, parent):
            nonlocal res
            count = [0, 0]
            if is_prime[node]:
                count[1] = 1
            else:
                count[0] = 1
            for neighbor in graph[node]:
                if neighbor == parent:
                    continue
                child_count = dfs(neighbor, node)
                res += child_count[0] * count[1] + child_count[1] * count[0]
                if is_prime[node]:
                    count[1] += child_count[1]
                else:
                    count[0] += child_count[0]
                    count[1] += child_count[1]
            return count

        dfs(1, -1)
        return res