class Solution:
    def countHighestScoreNodes(self, parents: List[int]) -> int:
        n = len(parents)
        children = [[] for _ in range(n)]
        for i in range(1, n):
            children[parents[i]].append(i)

        max_score = 0
        count = 0

        def dfs(node):
            nonlocal max_score, count
            size = 1
            score = 1
            for child in children[node]:
                subtree_size = dfs(child)
                size += subtree_size
                score *= subtree_size
            if node != 0:
                score *= (n - size)
            if score > max_score:
                max_score = score
                count = 1
            elif score == max_score:
                count += 1
            return size

        dfs(0)
        return count