import collections
import heapq

class Solution:
    def reachableNodes(self, edges: list[list[int]], maxMoves: int, n: int) -> int:
        graph = collections.defaultdict(list)
        for u, v, wt in edges:
            graph[u].append((v, wt))
            graph[v].append((u, wt))

        dist = [float('inf')] * n
        dist[0] = 0

        # Priority queue stores (moves_taken, node_id)
        pq = [(0, 0)] 

        while pq:
            d, u = heapq.heappop(pq)

            if d > dist[u]:
                continue

            for v, wt in graph[u]:
                # The actual cost to traverse the original edge (u, v)
                # including all 'wt' new nodes is wt + 1.
                # (wt segments for new nodes + 1 segment to reach v from the last new node)
                if d + wt + 1 < dist[v]:
                    dist[v] = d + wt + 1
                    heapq.heappush(pq, (dist[v], v))

        reachable_nodes_count = 0

        # Count reachable original nodes
        for i in range(n):
            if dist[i] <= maxMoves:
                reachable_nodes_count += 1

        # Count reachable new nodes on each subdivided edge
        for u, v, wt in edges:
            # Calculate how many new nodes can be reached from node u towards v
            reachable_from_u = 0
            if dist[u] <= maxMoves:
                # Moves available from u: maxMoves - dist[u]
                # We can traverse at most 'wt' new nodes on this edge
                reachable_from_u = min(wt, maxMoves - dist[u])

            # Calculate how many new nodes can be reached from node v towards u
            reachable_from_v = 0
            if dist[v] <= maxMoves:
                # Moves available from v: maxMoves - dist[v]
                # We can traverse at most 'wt' new nodes on this edge
                reachable_from_v = min(wt, maxMoves - dist[v])

            # The total unique new nodes reachable on this edge (u, v)
            # is the sum of nodes reachable from u and v, but capped by 'wt'
            # because there are only 'wt' new nodes in total on this edge.
            reachable_nodes_count += min(wt, reachable_from_u + reachable_from_v)

        return reachable_nodes_count