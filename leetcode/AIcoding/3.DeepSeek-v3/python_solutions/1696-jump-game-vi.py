import heapq

class Solution:
    def maxResult(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n
        dp[0] = nums[0]
        max_heap = [(-dp[0], 0)]

        for i in range(1, n):
            while max_heap[0][1] < i - k:
                heapq.heappop(max_heap)
            dp[i] = nums[i] + dp[max_heap[0][1]]
            heapq.heappush(max_heap, (-dp[i], i))

        return dp[-1]