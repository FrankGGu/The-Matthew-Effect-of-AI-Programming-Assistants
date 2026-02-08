import heapq

class Solution:
    def findScore(self, nums: list[int]) -> int:
        n = len(nums)
        score = 0
        marked = [False] * n

        min_heap = []
        for i in range(n):
            heapq.heappush(min_heap, (nums[i], i))

        while min_heap:
            val, idx = heapq.heappop(min_heap)

            if not marked[idx]:
                score += val
                marked[idx] = True
                if idx - 1 >= 0:
                    marked[idx - 1] = True
                if idx + 1 < n:
                    marked[idx + 1] = True

        return score