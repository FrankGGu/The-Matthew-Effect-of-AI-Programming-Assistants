import heapq
from collections import defaultdict

class Solution:
    def reachableNodes(self, edges: List[List[int]], maxMoves: int, n: int) -> int:
        graph = defaultdict(list)
        for u, v, cnt in edges:
            graph[u].append((v, cnt))
            graph[v].append((u, cnt))

        min_heap = [(0, 0)]  # (cost, node)
        best = [0] * n
        while min_heap:
            moves, node = heapq.heappop(min_heap)
            if moves > maxMoves:
                continue
            if best[node] < moves:
                best[node] = moves
                for neighbor, cnt in graph[node]:
                    if best[neighbor] < moves + cnt + 1:
                        heapq.heappush(min_heap, (moves + cnt + 1, neighbor))

        result = sum(1 for b in best if b <= maxMoves)
        for u, v, cnt in edges:
            reach_u = min(best[u], maxMoves)
            reach_v = min(best[v], maxMoves)
            result += min(cnt, reach_u + reach_v)

        return result