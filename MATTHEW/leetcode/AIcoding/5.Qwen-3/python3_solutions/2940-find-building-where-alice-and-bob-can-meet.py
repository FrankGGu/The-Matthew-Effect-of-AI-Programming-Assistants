class Solution:
    def est(self, heights: List[int]) -> int:
        n = len(heights)
        left = [0] * n
        right = [0] * n
        stack = []
        for i in range(n):
            while stack and heights[stack[-1]] < heights[i]:
                stack.pop()
            if stack:
                left[i] = stack[-1]
            else:
                left[i] = -1
            stack.append(i)
        stack = []
        for i in range(n - 1, -1, -1):
            while stack and heights[stack[-1]] < heights[i]:
                stack.pop()
            if stack:
                right[i] = stack[-1]
            else:
                right[i] = n
            stack.append(i)
        res = -1
        for i in range(n):
            if left[i] != -1 and right[i] != n:
                res = max(res, i)
        return res