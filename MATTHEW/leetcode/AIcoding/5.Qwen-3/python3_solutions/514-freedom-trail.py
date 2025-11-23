class Solution:
    def findRotateSteps(self, ring: str, key: str) -> int:
        from collections import defaultdict
        import heapq

        pos = defaultdict(list)
        n = len(ring)
        for i, c in enumerate(ring):
            pos[c].append(i)

        def dist(a, b):
            return min(abs(a - b), n - abs(a - b))

        heap = [(0, 0)]
        visited = set()

        while heap:
            steps, idx = heapq.heappop(heap)
            if idx == len(key):
                return steps
            if (idx, steps) in visited:
                continue
            visited.add((idx, steps))
            c = key[idx]
            for p in pos[c]:
                d = dist(p, 0)
                heapq.heappush(heap, (steps + d + 1, idx + 1))