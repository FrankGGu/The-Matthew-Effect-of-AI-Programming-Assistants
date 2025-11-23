class Solution:
    def maximumGeneticDifference(self, parents: List[int], queries: List[List[int]]) -> List[int]:
        n = len(parents)
        graph = [[] for _ in range(n)]

        for i in range(n):
            if parents[i] != -1:
                graph[parents[i]].append(i)

        def dfs(node, depth):
            max_depth[node] = depth
            for child in graph[node]:
                dfs(child, depth + 1)

        max_depth = [0] * n
        for i in range(n):
            if parents[i] == -1:
                dfs(i, 1)

        result = []
        for u, v in queries:
            result.append(max_depth[u] + max_depth[v] - 2 * max_depth[self.lca(u, v, parents)])

        return result

    def lca(self, u, v, parents):
        # Function to find LCA of u and v
        if u == v:
            return u
        if u < v:
            u, v = v, u

        depth_u = self.get_depth(u, parents)
        depth_v = self.get_depth(v, parents)

        while depth_u > depth_v:
            u = parents[u]
            depth_u -= 1
        while u != v:
            u = parents[u]
            v = parents[v]
        return u

    def get_depth(self, node, parents):
        depth = 0
        while node != -1:
            node = parents[node]
            depth += 1
        return depth