class Solution:
    def maximumScore(self, s: str, nums: List[int]) -> int:
        stack = []
        total_score = 0

        for i in range(len(s)):
            while stack and s[stack[-1]] < s[i]:
                j = stack.pop()
                total_score += nums[j]
            stack.append(i)

        while stack:
            j = stack.pop()
            total_score += nums[j]

        return total_score