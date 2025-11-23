import heapq

class Solution:
    def busRapidTransit(self, target: int, inc: int, dec: int, jump: List[int], cost: List[int]) -> int:
        MOD = 10**9 + 7
        heap = []
        heapq.heappush(heap, (0, target))
        visited = {}

        while heap:
            time, pos = heapq.heappop(heap)
            if pos == 0:
                return time % MOD
            if pos in visited and visited[pos] <= time:
                continue
            visited[pos] = time

            # Option 1: Walk to 0
            walk_time = time + pos * inc
            if 0 not in visited or walk_time < visited.get(0, float('inf')):
                heapq.heappush(heap, (walk_time, 0))

            # Option 2: Try all possible jumps
            for j, c in zip(jump, cost):
                q, r = divmod(pos, j)
                if r == 0:
                    if q not in visited or time + c < visited.get(q, float('inf')):
                        heapq.heappush(heap, (time + c, q))
                else:
                    # Option 2a: Walk up to next multiple
                    walk_up_time = time + (j - r) * inc + c
                    if q + 1 not in visited or walk_up_time < visited.get(q + 1, float('inf')):
                        heapq.heappush(heap, (walk_up_time, q + 1))
                    # Option 2b: Walk down to previous multiple
                    walk_down_time = time + r * dec + c
                    if q not in visited or walk_down_time < visited.get(q, float('inf')):
                        heapq.heappush(heap, (walk_down_time, q))

        return -1