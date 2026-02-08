class Solution:
    def areConnected(self, n: int, edges: List[List[int]], queries: List[List[int]]) -> List[bool]:
        adj = [[] for _ in range(n + 1)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        def bfs(start, end):
            q = collections.deque([start])
            visited = {start}
            while q:
                curr = q.popleft()
                if curr == end:
                    return True
                for neighbor in adj[curr]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        q.append(neighbor)
            return False

        result = []
        for u, v in queries:
            result.append(bfs(u, v))
        return result