class Solution:
    def maxKelements(self, nums: List[int], k: int) -> int:
        import heapq
        max_heap = []
        for num in nums:
            heapq.heappush(max_heap, -num)

        total = 0
        for _ in range(k):
            current = -heapq.heappop(max_heap)
            total += current
            heapq.heappush(max_heap, -(current + 2) // 3)

        return total