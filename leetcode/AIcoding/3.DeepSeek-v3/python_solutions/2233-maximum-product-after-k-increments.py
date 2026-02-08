import heapq

class Solution:
    def maximumProduct(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        heap = nums.copy()
        heapq.heapify(heap)

        for _ in range(k):
            smallest = heapq.heappop(heap)
            heapq.heappush(heap, smallest + 1)

        result = 1
        for num in heap:
            result = (result * num) % MOD

        return result