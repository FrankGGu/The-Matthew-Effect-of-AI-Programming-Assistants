import heapq

class Solution:
    def kthSmallest(self, denominations: List[int], k: int) -> int:
        heap = [0]
        visited = {0}

        for _ in range(k):
            curr = heapq.heappop(heap)

            for denom in denominations:
                next_val = curr + denom
                if next_val not in visited:
                    heapq.heappush(heap, next_val)
                    visited.add(next_val)

        return curr