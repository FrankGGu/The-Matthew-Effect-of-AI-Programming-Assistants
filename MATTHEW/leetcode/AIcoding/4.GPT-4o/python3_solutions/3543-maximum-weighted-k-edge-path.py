class Solution:
    def maximumWeightedKEdgePath(self, edges: List[List[int]], k: int) -> int:
        from collections import defaultdict
        import heapq

        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        max_weight = 0
        for start in graph:
            max_weight = max(max_weight, self.dijkstra(graph, start, k))

        return max_weight

    def dijkstra(self, graph, start, k):
        max_heap = [(-0, start, 0)]
        visited = defaultdict(lambda: float('-inf'))
        visited[(start, 0)] = 0

        while max_heap:
            current_weight, current_node, current_edges = heapq.heappop(max_heap)
            current_weight = -current_weight

            if current_edges == k:
                continue

            for neighbor, weight in graph[current_node]:
                new_weight = current_weight + weight
                new_edges = current_edges + 1

                if new_edges <= k and new_weight > visited[(neighbor, new_edges)]:
                    visited[(neighbor, new_edges)] = new_weight
                    heapq.heappush(max_heap, (-new_weight, neighbor, new_edges))

        return max(visited.values(), default=0)