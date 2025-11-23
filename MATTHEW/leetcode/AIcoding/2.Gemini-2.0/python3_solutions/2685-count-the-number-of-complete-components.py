class Solution:
    def countCompleteComponents(self, n: int, edges: List[List[int]]) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visited = [False] * n
        count = 0

        def dfs(node, component_nodes, component_edges):
            visited[node] = True
            component_nodes.add(node)
            for neighbor in adj[node]:
                component_edges.add(tuple(sorted((node, neighbor))))
                if not visited[neighbor]:
                    dfs(neighbor, component_nodes, component_edges)

        for i in range(n):
            if not visited[i]:
                component_nodes = set()
                component_edges = set()
                dfs(i, component_nodes, component_edges)

                num_nodes = len(component_nodes)
                num_edges = len(component_edges)

                if num_edges == num_nodes * (num_nodes - 1) // 2:
                    count += 1

        return count