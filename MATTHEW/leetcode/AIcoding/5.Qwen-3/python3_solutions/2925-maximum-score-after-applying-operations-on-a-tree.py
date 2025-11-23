class Solution:
    def maximumScore(self, edges: List[List[int]], scores: List[int]) -> int:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        def dfs(node, parent):
            res = scores[node]
            for child in tree[node]:
                if child != parent:
                    res += dfs(child, node)
            return res

        def get_scores(node, parent):
            total = scores[node]
            for child in tree[node]:
                if child != parent:
                    total += get_scores(child, node)
            return total

        max_score = 0
        for i in range(len(edges) + 1):
            for j in range(i + 1, len(edges) + 1):
                if i == j:
                    continue
                total = 0
                visited = set()
                stack = [(i, -1)]
                while stack:
                    node, p = stack.pop()
                    if node in visited:
                        continue
                    visited.add(node)
                    total += scores[node]
                    for child in tree[node]:
                        if child != p:
                            stack.append((child, node))
                total2 = 0
                stack = [(j, -1)]
                visited = set()
                while stack:
                    node, p = stack.pop()
                    if node in visited:
                        continue
                    visited.add(node)
                    total2 += scores[node]
                    for child in tree[node]:
                        if child != p:
                            stack.append((child, node))
                max_score = max(max_score, total * total2)
        return max_score