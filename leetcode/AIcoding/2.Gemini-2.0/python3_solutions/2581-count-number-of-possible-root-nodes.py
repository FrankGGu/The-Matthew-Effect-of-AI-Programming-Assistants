from collections import defaultdict

class Solution:
    def rootCount(self, edges: list[list[int]], guesses: list[list[int]], k: int) -> int:
        n = len(edges) + 1
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        correct_guesses = 0
        for u, v in guesses:
            if v in graph[u]:
                correct_guesses += 1

        ans = 0

        def dfs(node, parent, correct):
            nonlocal ans
            if correct >= k:
                ans += 1

            for neighbor in graph[node]:
                if neighbor != parent:
                    new_correct = correct
                    if node in [g[0] for g in guesses] and neighbor in [g[1] for g in guesses]:
                        if [node, neighbor] in guesses:
                            new_correct -= 1
                    if neighbor in [g[0] for g in guesses] and node in [g[1] for g in guesses]:
                        if [neighbor, node] in guesses:
                            new_correct += 1

                    dfs(neighbor, node, new_correct)

        dfs(0, -1, correct_guesses)
        return ans