class Solution:
    def maximumInvitations(self, favorite: List[int]) -> int:
        n = len(favorite)
        visited = [False] * n
        max_cycle = 0
        pairs = []

        for i in range(n):
            if not visited[i]:
                path = []
                current = i
                while True:
                    if visited[current]:
                        if current in path:
                            idx = path.index(current)
                            cycle_len = len(path) - idx
                            if cycle_len == 2:
                                pairs.append((current, favorite[current]))
                            else:
                                max_cycle = max(max_cycle, cycle_len)
                        break
                    visited[current] = True
                    path.append(current)
                    current = favorite[current]

        graph = defaultdict(list)
        for u, v in pairs:
            graph[u].append(v)
            graph[v].append(u)

        def dfs(node, parent):
            max_depth = 0
            for neighbor in graph[node]:
                if neighbor != parent:
                    max_depth = max(max_depth, dfs(neighbor, node))
            return max_depth + 1

        total_pairs = 0
        visited_pairs = set()
        for u, v in pairs:
            if u not in visited_pairs and v not in visited_pairs:
                len_u = dfs(u, v)
                len_v = dfs(v, u)
                total_pairs += len_u + len_v
                visited_pairs.add(u)
                visited_pairs.add(v)

        return max(max_cycle, total_pairs)