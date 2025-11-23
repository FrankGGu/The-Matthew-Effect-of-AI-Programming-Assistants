class Solution:
    def minSumSquare(self, nums: List[int], k: int) -> int:
        import heapq
        heap = []
        for num in nums:
            heapq.heappush(heap, -num)
        for _ in range(k):
            current = -heapq.heappop(heap)
            current -= 1
            heapq.heappush(heap, -current)
        return sum(-x * -x for x in heap)