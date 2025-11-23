class Solution:
    def minReorder(self, n: int, connections: List[List[int]]) -> int:
        graph = defaultdict(list)
        for u, v in connections:
            graph[u].append((v, 1))
            graph[v].append((u, 0))

        def dfs(node, parent):
            count = 0
            for neighbor, need_reorder in graph[node]:
                if neighbor != parent:
                    count += need_reorder + dfs(neighbor, node)
            return count

        return dfs(0, -1)