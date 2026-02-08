import heapq
import math

class Solution:
    def maxScore(self, nums: list[int], k: int) -> int:
        pq = []
        for num in nums:
            heapq.heappush(pq, -num)

        total_score = 0
        for _ in range(k):
            current_neg_num = heapq.heappop(pq)
            current_num = -current_neg_num

            total_score += current_num

            new_num = current_num // 3
            heapq.heappush(pq, -new_num)

        return total_score