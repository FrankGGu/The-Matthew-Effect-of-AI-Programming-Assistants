import heapq

class Solution:
    def kthSmallestPrimeFraction(self, arr: list[int], k: int) -> list[int]:
        pq = []
        n = len(arr)
        for i in range(n):
            heapq.heappush(pq, (arr[0] / arr[i], 0, i))

        for _ in range(k - 1):
            val, p_idx, q_idx = heapq.heappop(pq)
            if p_idx + 1 < n:
                heapq.heappush(pq, (arr[p_idx + 1] / arr[q_idx], p_idx + 1, q_idx))

        val, p_idx, q_idx = heapq.heappop(pq)
        return [arr[p_idx], arr[q_idx]]