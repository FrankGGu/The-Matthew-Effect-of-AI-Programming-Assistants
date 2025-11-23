class Solution:
    def collectTheCoins(self, coins: List[int], edges: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        leaves = deque()
        for i in range(len(coins)):
            if coins[i] == 0:
                leaves.append(i)

        while len(leaves) > 0:
            leaf = leaves.popleft()
            for neighbor in graph[leaf]:
                if coins[leaf] == 0:
                    graph[neighbor].remove(leaf)
                    if coins[neighbor] == 0 and len(graph[neighbor]) == 1:
                        leaves.append(neighbor)

        cost = 0
        for u, v in edges:
            if coins[u] > 0 or coins[v] > 0:
                cost += 1
        return max(0, cost - 2)