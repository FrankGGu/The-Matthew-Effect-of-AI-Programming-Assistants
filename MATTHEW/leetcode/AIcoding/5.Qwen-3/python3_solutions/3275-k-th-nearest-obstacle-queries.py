class Solution:
    def hardestHit(self, n: int, k: int, queries: List[List[int]]) -> List[int]:
        from collections import defaultdict
        import heapq

        obstacles = defaultdict(list)
        for i, (x, y) in enumerate(queries):
            if y != -1:
                obstacles[y].append((x, i))

        result = [0] * len(queries)

        for y in obstacles:
            sorted_obstacles = sorted(obstacles[y], key=lambda x: x[0])
            heap = []
            for x, idx in sorted_obstacles:
                while heap and heap[0][0] < x - k:
                    _, i = heapq.heappop(heap)
                    result[i] += 1
                heapq.heappush(heap, (x, idx))

        return result