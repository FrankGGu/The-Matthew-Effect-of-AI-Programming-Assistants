import heapq

class Solution:
    def maximumScore(self, a: int, b: int, c: int) -> int:
        stones = [-a, -b, -c]
        heapq.heapify(stones)
        score = 0
        while len(stones) > 1:
            x = heapq.heappop(stones)
            y = heapq.heappop(stones)
            score += -x + -y
            if y - 1 < 0:
                heapq.heappush(stones, y - 1)
            if x - 1 < 0:
                heapq.heappush(stones, x - 1)
        return score