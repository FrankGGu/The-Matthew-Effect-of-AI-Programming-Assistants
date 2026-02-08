from collections import defaultdict

class Solution:
    def loudAndRich(self, richer: list[list[int]], quiet: list[int]) -> list[int]:
        n = len(quiet)
        graph = defaultdict(list)
        for a, b in richer:
            graph[b].append(a)

        ans = [-1] * n

        def dfs(node):
            if ans[node] != -1:
                return ans[node]

            min_quiet = quiet[node]
            min_person = node

            for neighbor in graph[node]:
                neighbor_ans = dfs(neighbor)
                if quiet[neighbor_ans] < min_quiet:
                    min_quiet = quiet[neighbor_ans]
                    min_person = neighbor_ans

            ans[node] = min_person
            return min_person

        for i in range(n):
            dfs(i)

        return ans