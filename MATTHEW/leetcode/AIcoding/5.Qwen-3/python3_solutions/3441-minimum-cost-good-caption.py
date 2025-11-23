class Solution:
    def minimumCost(self, n: int, edges: List[List[int]], src: int, dst: int, k: int) -> int:
        import heapq
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))

        heap = [(0, src, 0)]
        visited = {}

        while heap:
            cost, node, steps = heapq.heappop(heap)
            if node == dst:
                return cost
            if steps > k:
                continue
            if (node, steps) in visited and visited[(node, steps)] <= cost:
                continue
            visited[(node, steps)] = cost
            for neighbor, weight in graph[node]:
                heapq.heappush(heap, (cost + weight, neighbor, steps + 1))

        return -1