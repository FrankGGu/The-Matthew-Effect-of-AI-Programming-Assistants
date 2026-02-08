class Solution:
    def shortestDistance(self, n: int, roads: List[List[int]], queries: List[List[int]]) -> List[int]:
        from collections import defaultdict
        import heapq

        graph = defaultdict(list)
        for u, v, w in roads:
            graph[u].append((v, w))
            graph[v].append((u, w))

        def dijkstra(start):
            dist = [float('inf')] * n
            dist[start] = 0
            min_heap = [(0, start)]
            while min_heap:
                d, node = heapq.heappop(min_heap)
                if d > dist[node]:
                    continue
                for neighbor, weight in graph[node]:
                    if dist[node] + weight < dist[neighbor]:
                        dist[neighbor] = dist[node] + weight
                        heapq.heappush(min_heap, (dist[neighbor], neighbor))
            return dist

        original_dist = dijkstra(0)
        answers = []

        for u, v in queries:
            additional_distance = float('inf')
            for neighbor, weight in graph[u]:
                if original_dist[neighbor] < float('inf'):
                    additional_distance = min(additional_distance, original_dist[neighbor] + weight)
            for neighbor, weight in graph[v]:
                if original_dist[neighbor] < float('inf'):
                    additional_distance = min(additional_distance, original_dist[neighbor] + weight)
            answers.append(min(original_dist[v], additional_distance) if additional_distance < float('inf') else original_dist[v])

        return answers