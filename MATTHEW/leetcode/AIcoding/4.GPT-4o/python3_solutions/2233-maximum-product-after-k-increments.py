import heapq

class Solution:
    def maximumProduct(self, nums: List[int], k: int) -> int:
        heapq.heapify(nums)
        for _ in range(k):
            smallest = heapq.heappop(nums)
            heapq.heappush(nums, smallest + 1)
        result = 1
        for num in nums:
            result = (result * num) % (10**9 + 7)
        return result