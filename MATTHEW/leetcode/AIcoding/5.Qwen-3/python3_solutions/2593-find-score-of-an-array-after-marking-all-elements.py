class Solution:
    def findScore(self, nums: List[int]) -> int:
        import heapq
        n = len(nums)
        visited = [False] * n
        heap = []
        for i in range(n):
            heapq.heappush(heap, (nums[i], i))
        score = 0
        while heap:
            val, i = heapq.heappop(heap)
            if not visited[i]:
                score += val
                visited[i] = True
                if i > 0:
                    visited[i - 1] = True
                if i < n - 1:
                    visited[i + 1] = True
        return score