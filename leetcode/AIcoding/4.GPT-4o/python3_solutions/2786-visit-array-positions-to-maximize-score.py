class Solution:
    def maxScore(self, nums: List[int]) -> int:
        n = len(nums)
        nums.sort(reverse=True)
        score = 0
        visited = [False] * n
        for i in range(n):
            if not visited[i]:
                score += nums[i]
                visited[i] = True
                if i + 1 < n:
                    visited[i + 1] = True
        return score