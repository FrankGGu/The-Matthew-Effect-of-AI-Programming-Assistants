class Solution:
    def maximumScore(self, a: int, b: int, c: int) -> int:
        heap = [-a, -b, -c]
        heapq.heapify(heap)
        score = 0

        while True:
            first = -heapq.heappop(heap)
            second = -heapq.heappop(heap)
            if second == 0:
                break
            score += 1
            heapq.heappush(heap, -(first - 1))
            heapq.heappush(heap, -(second - 1))

        return score