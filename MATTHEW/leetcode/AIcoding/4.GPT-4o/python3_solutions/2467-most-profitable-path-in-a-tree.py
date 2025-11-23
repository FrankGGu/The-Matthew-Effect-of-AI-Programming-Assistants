from collections import defaultdict
import heapq

class Solution:
    def mostProfitablePath(self, edges: List[List[int]], bob: int, amount: List[int]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        n = len(amount)
        bob_path = [0] * n
        visited = set()

        def find_bob_path(node, depth):
            if node in visited:
                return
            visited.add(node)
            bob_path[depth] = node
            for neighbor in graph[node]:
                find_bob_path(neighbor, depth + 1)

        find_bob_path(bob, 0)

        max_profit = float('-inf')

        def dfs(node, parent, depth):
            nonlocal max_profit
            if depth < len(bob_path) and bob_path[depth] == node:
                profit = amount[node] // 2
            else:
                profit = amount[node]

            for neighbor in graph[node]:
                if neighbor != parent:
                    profit += dfs(neighbor, node, depth + 1)

            if depth == 0:
                max_profit = max(max_profit, profit)
            return profit

        dfs(0, -1, 0)
        return max_profit