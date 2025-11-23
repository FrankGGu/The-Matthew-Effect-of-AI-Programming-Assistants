import heapq

class Solution:
    def modifiedGraphEdges(self, n: int, edges: List[List[int]], source: int, destination: int, target: int) -> List[List[int]]:
        graph = [[] for _ in range(n)]
        for i, (u, v, w) in enumerate(edges):
            graph[u].append((v, w, i))
            graph[v].append((u, w, i))

        def dijkstra(start, skip_negative):
            dist = [float('inf')] * n
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                current_dist, u = heapq.heappop(heap)
                if current_dist > dist[u]:
                    continue
                for v, w, idx in graph[u]:
                    if w == -1:
                        if skip_negative:
                            continue
                        w = 1
                    if dist[v] > current_dist + w:
                        dist[v] = current_dist + w
                        heapq.heappush(heap, (dist[v], v))
            return dist

        dist_source = dijkstra(source, skip_negative=True)
        if dist_source[destination] < target:
            return []

        dist_dest = dijkstra(destination, skip_negative=True)
        if dist_dest[source] > target:
            return []

        dist = dijkstra(source, skip_negative=False)
        if dist[destination] > target:
            return []

        for i, (u, v, w) in enumerate(edges):
            if w == -1:
                edges[i][2] = 1

        dist = [float('inf')] * n
        dist[source] = 0
        heap = [(0, source)]
        parent = {}

        while heap:
            current_dist, u = heapq.heappop(heap)
            if u == destination:
                break
            if current_dist > dist[u]:
                continue
            for v, w, idx in graph[u]:
                if dist[v] > current_dist + w:
                    dist[v] = current_dist + w
                    parent[v] = (u, idx)
                    heapq.heappush(heap, (dist[v], v))

        if dist[destination] < target:
            return []

        path = []
        u = destination
        while u != source:
            path.append(parent[u][1])
            u = parent[u][0]
        path = path[::-1]

        total = 0
        for idx in path:
            u, v, w = edges[idx]
            if w == -1:
                edges[idx][2] = 1
            total += edges[idx][2]

        remaining = target - total
        for idx in path:
            u, v, w = edges[idx]
            if edges[idx][2] == 1 and w == -1:
                edges[idx][2] += remaining
                remaining = 0
                break

        for i, (u, v, w) in enumerate(edges):
            if w == -1:
                edges[i][2] = 1

        return edges