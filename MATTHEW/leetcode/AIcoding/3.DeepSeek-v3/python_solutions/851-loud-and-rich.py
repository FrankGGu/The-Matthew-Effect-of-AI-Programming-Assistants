class Solution:
    def loudAndRich(self, richer: List[List[int]], quiet: List[int]) -> List[int]:
        n = len(quiet)
        graph = [[] for _ in range(n)]
        for u, v in richer:
            graph[v].append(u)

        answer = [-1] * n

        def dfs(node):
            if answer[node] != -1:
                return answer[node]
            answer[node] = node
            for neighbor in graph[node]:
                candidate = dfs(neighbor)
                if quiet[candidate] < quiet[answer[node]]:
                    answer[node] = candidate
            return answer[node]

        for i in range(n):
            dfs(i)

        return answer