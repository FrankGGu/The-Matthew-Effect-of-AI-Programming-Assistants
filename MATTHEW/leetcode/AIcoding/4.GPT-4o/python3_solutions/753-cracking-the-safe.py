class Solution:
    def crackSafe(self, n: int, k: int) -> str:
        def dfs(node, visited, result):
            for x in range(k):
                next_node = node + str(x)
                if next_node not in visited:
                    visited.add(next_node)
                    dfs(next_node[1:], visited, result)
                    result.append(str(x))

        visited = set()
        result = []
        start_node = "0" * (n - 1)
        visited.add(start_node)
        dfs(start_node, visited, result)
        return start_node + ''.join(result)[::-1]