class Solution:
    def magicTower(self, nums: List[int]) -> int:
        total = 0
        min_heap = []
        health = 1

        for num in nums:
            total += num
            heapq.heappush(min_heap, num)
            if total < 0:
                total -= heapq.heappop(min_heap)

        return len(min_heap) if total >= 0 else -1