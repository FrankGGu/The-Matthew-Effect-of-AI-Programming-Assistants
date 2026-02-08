import heapq

class Solution:
    def maximumProduct(self, nums: list[int], k: int) -> int:
        heapq.heapify(nums)

        for _ in range(k):
            smallest = heapq.heappop(nums)
            heapq.heappush(nums, smallest + 1)

        MOD = 10**9 + 7
        product = 1
        for num in nums:
            product = (product * num) % MOD

        return product