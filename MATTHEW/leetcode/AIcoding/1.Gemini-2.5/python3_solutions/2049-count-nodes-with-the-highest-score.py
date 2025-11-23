class Solution:
    def countHighestScoreNodes(self, parents: list[int]) -> int:
        n = len(parents)

        adj = [[] for _ in range(n)]
        for i in range(1, n):
            adj[parents[i]].append(i)

        scores = [0] * n

        def dfs(u: int) -> int:
            current_subtree_size = 1
            score_product = 1

            children_subtree_sizes = []
            for v in adj[u]:
                child_size = dfs(v)
                children_subtree_sizes.append(child_size)
                current_subtree_size += child_size

            for size in children_subtree_sizes:
                score_product *= size

            size_above_u = n - current_subtree_size

            if size_above_u > 0:
                score_product *= size_above_u

            scores[u] = score_product
            return current_subtree_size

        dfs(0)

        max_score = 0
        count = 0

        for score in scores:
            if score > max_score:
                max_score = score
                count = 1
            elif score == max_score:
                count += 1

        return count