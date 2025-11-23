class Solution:
    def minTime(self, n: int, edges: List[List[int]], hasApple: List[bool]) -> int:
        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        visited = set()

        def dfs(node):
            visited.add(node)
            total_time = 0
            for child in tree[node]:
                if child not in visited:
                    child_time = dfs(child)
                    if child_time > 0 or hasApple[child]:
                        total_time += child_time + 2
            return total_time

        return dfs(0)