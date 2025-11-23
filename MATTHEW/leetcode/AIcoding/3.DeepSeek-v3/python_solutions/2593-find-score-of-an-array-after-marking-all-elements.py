import heapq

class Solution:
    def findScore(self, nums: List[int]) -> int:
        n = len(nums)
        marked = [False] * n
        heap = []
        for i, num in enumerate(nums):
            heapq.heappush(heap, (num, i))

        score = 0
        while heap:
            num, i = heapq.heappop(heap)
            if not marked[i]:
                score += num
                marked[i] = True
                if i > 0:
                    marked[i-1] = True
                if i < n - 1:
                    marked[i+1] = True
        return score