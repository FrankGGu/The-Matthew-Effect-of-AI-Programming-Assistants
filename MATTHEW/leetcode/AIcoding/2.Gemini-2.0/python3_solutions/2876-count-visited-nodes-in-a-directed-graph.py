class Solution:
    def countVisitedNodes(self, edges: list[int]) -> list[int]:
        n = len(edges)
        ans = [0] * n
        graph = [[] for _ in range(n)]
        for i, edge in enumerate(edges):
            graph[i].append(edge)

        def dfs(node, path, path_nodes):
            if ans[node] > 0:
                return ans[node]

            if node in path_nodes:
                cycle_start = path_nodes.index(node)
                cycle_len = len(path_nodes) - cycle_start
                for i in range(cycle_len):
                    ans[path_nodes[cycle_start + i]] = cycle_len

                for i in range(cycle_start):
                    ans[path_nodes[i]] = dfs(path_nodes[i], [], [])

                return ans[node]

            path_nodes.append(node)
            path.append(node)

            neighbor = edges[node]
            ans[node] = dfs(neighbor, path, path_nodes) + 1

            return ans[node]

        for i in range(n):
            if ans[i] == 0:
                dfs(i, [], [])

        return ans