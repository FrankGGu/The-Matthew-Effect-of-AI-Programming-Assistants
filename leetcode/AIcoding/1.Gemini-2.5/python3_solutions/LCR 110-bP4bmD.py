class Solution:
    def allPathsSourceTarget(self, graph: list[list[int]]) -> list[list[int]]:
        n = len(graph)
        target_node = n - 1
        all_paths = []

        def dfs(node, current_path):
            current_path.append(node)

            if node == target_node:
                all_paths.append(list(current_path))
            else:
                for neighbor in graph[node]:
                    dfs(neighbor, current_path)

            current_path.pop()

        dfs(0, [])
        return all_paths