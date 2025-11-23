class Solution:
    def maxNumOfTargetNodes(self, edges: List[List[int]], target: List[int]) -> int:
        from collections import defaultdict, deque

        n = len(edges) + 1
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        target_set = set(target)
        count = 0
        for node in range(n):
            if node in target_set:
                count += 1

        if count <= 1:
            return count

        def bfs(start):
            visited = [False] * n
            q = deque()
            q.append(start)
            visited[start] = True
            distance = 0
            target_found = 0
            while q:
                level_size = len(q)
                for _ in range(level_size):
                    current = q.popleft()
                    if current in target_set:
                        target_found += 1
                    for neighbor in adj[current]:
                        if not visited[neighbor]:
                            visited[neighbor] = True
                            q.append(neighbor)
                distance += 1
                if target_found >= 2:
                    return True
            return False

        res = 0
        for node in range(n):
            if node in target_set and bfs(node):
                res += 1

        return res