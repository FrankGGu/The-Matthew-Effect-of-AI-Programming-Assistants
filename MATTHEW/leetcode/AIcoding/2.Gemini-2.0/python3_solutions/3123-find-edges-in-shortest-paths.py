import heapq

def findTheCity(n, edges, distanceThreshold):
    adj = [[] for _ in range(n)]
    for u, v, w in edges:
        adj[u].append((v, w))
        adj[v].append((u, w))

    def dijkstra(start):
        dist = [float('inf')] * n
        dist[start] = 0
        pq = [(0, start)]
        while pq:
            d, u = heapq.heappop(pq)
            if d > dist[u]:
                continue
            for v, w in adj[u]:
                if dist[u] + w < dist[v]:
                    dist[v] = dist[u] + w
                    heapq.heappush(pq, (dist[v], v))
        return dist

    reachable_counts = []
    for i in range(n):
        distances = dijkstra(i)
        count = 0
        for d in distances:
            if d <= distanceThreshold:
                count += 1
        reachable_counts.append(count)

    min_reachable = min(reachable_counts)
    for i in range(n - 1, -1, -1):
        if reachable_counts[i] == min_reachable:
            return i

def findCriticalAndPseudoCriticalEdges(n, edges):
    m = len(edges)
    adj = [[] for _ in range(n)]
    for i, (u, v, w) in enumerate(edges):
        adj[u].append((v, w, i))
        adj[v].append((u, w, i))

    def dijkstra(start, end):
        dist = [float('inf')] * n
        dist[start] = 0
        pq = [(0, start)]
        parents = [[] for _ in range(n)]
        while pq:
            d, u = heapq.heappop(pq)
            if d > dist[u]:
                continue
            for v, w, idx in adj[u]:
                if dist[u] + w < dist[v]:
                    dist[v] = dist[u] + w
                    pq = [(d, node) for d, node in pq if node != v]
                    heapq.heappush(pq, (dist[v], v))
                    parents[v] = [idx]
                elif dist[u] + w == dist[v]:
                    parents[v].append(idx)
        return dist, parents

    critical_edges = []
    pseudo_critical_edges = []

    for i in range(m):
        temp_adj = [[] for _ in range(n)]
        for u in range(n):
            for v, w, idx in adj[u]:
                if idx != i:
                    temp_adj[u].append((v, w, idx))

        def dijkstra_without_edge(start, end):
            dist = [float('inf')] * n
            dist[start] = 0
            pq = [(0, start)]
            while pq:
                d, u = heapq.heappop(pq)
                if d > dist[u]:
                    continue
                for v, w, idx in temp_adj[u]:
                    if dist[u] + w < dist[v]:
                        dist[v] = dist[u] + w
                        pq = [(d, node) for d, node in pq if node != v]
                        heapq.heappush(pq, (dist[v], v))
            return dist

        dist_without_edge = dijkstra_without_edge(0, n - 1)[n - 1]
        dist_with_edge, parents = dijkstra(0, n - 1)
        min_dist = dist_with_edge[n-1]

        if dist_without_edge > min_dist:
            critical_edges.append(i)
        else:
            u, v, w = edges[i]
            adj_with_forced_edge = [[] for _ in range(n)]
            for x in range(n):
                for y, z, idx in adj[x]:
                    adj_with_forced_edge[x].append((y, z, idx))

            adj_with_forced_edge[u] = [(v, w, i)]
            adj_with_forced_edge[v] = [(u, w, i)]

            def dijkstra_with_forced_edge(start, end):
                dist = [float('inf')] * n
                dist[start] = 0
                pq = [(0, start)]
                while pq:
                    d, u = heapq.heappop(pq)
                    if d > dist[u]:
                        continue
                    for v, w, idx in adj_with_forced_edge[u]:
                        if dist[u] + w < dist[v]:
                            dist[v] = dist[u] + w
                            pq = [(d, node) for d, node in pq if node != v]
                            heapq.heappush(pq, (dist[v], v))
                return dist[end]

            dist_with_forced = dijkstra_with_forced_edge(0, n-1)

            dist_with_edge_regular, parents_regular = dijkstra(0, n-1)
            min_dist_regular = dist_with_edge_regular[n-1]

            if dist_with_forced == min_dist_regular:
                pseudo_critical_edges.append(i)

    return [critical_edges, pseudo_critical_edges]