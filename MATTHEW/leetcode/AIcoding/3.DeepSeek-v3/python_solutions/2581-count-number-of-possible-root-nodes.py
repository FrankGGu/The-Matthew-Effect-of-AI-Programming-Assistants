import collections

class Solution:
    def countHighestScoreNodes(self, parents: List[int]) -> int:
        n = len(parents)
        children = collections.defaultdict(list)
        for i in range(n):
            if parents[i] != -1:
                children[parents[i]].append(i)

        height = [0] * n
        size = [0] * n

        def dfs(u):
            max_h = 0
            size[u] = 1
            for v in children[u]:
                h = dfs(v)
                max_h = max(max_h, h)
                size[u] += size[v]
            height[u] = max_h + 1
            return height[u]

        root = -1
        for i in range(n):
            if parents[i] == -1:
                root = i
                break
        dfs(root)

        min_height = min(height)
        count = 0
        for i in range(n):
            if height[i] == min_height:
                count += 1
        return count