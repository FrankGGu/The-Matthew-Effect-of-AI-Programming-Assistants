class Solution:
    def maxWidthRamp(self, A: List[int]) -> int:
        n = len(A)
        max_width = 0
        stack = []

        for i in range(n):
            if not stack or A[stack[-1]] > A[i]:
                stack.append(i)

        for j in range(n - 1, -1, -1):
            while stack and A[stack[-1]] <= A[j]:
                max_width = max(max_width, j - stack.pop())

        return max_width