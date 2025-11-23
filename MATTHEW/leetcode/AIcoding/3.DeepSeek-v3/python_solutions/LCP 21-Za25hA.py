import collections

class Solution:
    def chaseGame(self, edges, startA, startB):
        n = len(edges)
        graph = collections.defaultdict(list)
        for a, b in edges:
            graph[a].append(b)
            graph[b].append(a)

        # BFS to find distance from A and B
        def bfs(start):
            dist = [-1] * (n + 1)
            q = collections.deque()
            q.append(start)
            dist[start] = 0
            while q:
                u = q.popleft()
                for v in graph[u]:
                    if dist[v] == -1:
                        dist[v] = dist[u] + 1
                        q.append(v)
            return dist

        distA = bfs(startA)
        distB = bfs(startB)

        # Check if B can catch A immediately
        if distA[startB] == 1:
            return 1

        # Find the cycle in the graph
        parent = [0] * (n + 1)
        visited = [False] * (n + 1)
        cycle_nodes = set()
        stack = [(1, None)]
        found = False
        while stack and not found:
            u, p = stack.pop()
            if visited[u]:
                # Found a cycle
                cycle_start = u
                cycle_nodes.add(u)
                v = p
                while v != u:
                    cycle_nodes.add(v)
                    v = parent[v]
                found = True
                break
            visited[u] = True
            parent[u] = p
            for v in graph[u]:
                if v != p:
                    if not visited[v]:
                        stack.append((v, u))
                    else:
                        # Potential back edge
                        pass

        max_dist = 0
        for u in range(1, n + 1):
            if distA[u] > distB[u] + 1:
                if u in cycle_nodes and len(cycle_nodes) > 3:
                    return -1
                max_dist = max(max_dist, distA[u])

        return max_dist if max_dist != 0 else -1