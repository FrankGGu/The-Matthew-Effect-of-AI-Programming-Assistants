class Solution:
    def countHighestScoreNodes(self, parents: List[int]) -> int:
        n = len(parents)
        children = [[] for _ in range(n)]
        for i in range(1, n):
            children[parents[i]].append(i)

        def dfs(node):
            score = 1
            total_nodes = 0
            for child in children[node]:
                child_count = dfs(child)
                score *= child_count
                total_nodes += child_count
            if total_nodes < n - 1:
                score *= n - 1 - total_nodes
            self.scores[node] = score
            return total_nodes + 1

        self.scores = [0] * n
        dfs(0)
        max_score = max(self.scores)
        return self.scores.count(max_score)