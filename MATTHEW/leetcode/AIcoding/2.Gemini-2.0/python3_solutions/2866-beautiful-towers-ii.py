class Solution:
    def maximumSumOfHeights(self, maxHeights: list[int]) -> int:
        n = len(maxHeights)
        left = [0] * n
        right = [0] * n
        stack = []

        for i in range(n):
            while stack and maxHeights[stack[-1]] >= maxHeights[i]:
                stack.pop()
            if not stack:
                left[i] = (i + 1) * maxHeights[i]
            else:
                left[i] = left[stack[-1]] + (i - stack[-1]) * maxHeights[i]
            stack.append(i)

        stack = []
        for i in range(n - 1, -1, -1):
            while stack and maxHeights[stack[-1]] >= maxHeights[i]:
                stack.pop()
            if not stack:
                right[i] = (n - i) * maxHeights[i]
            else:
                right[i] = right[stack[-1]] + (stack[-1] - i) * maxHeights[i]
            stack.append(i)

        ans = 0
        for i in range(n):
            ans = max(ans, left[i] + right[i] - maxHeights[i])
        return ans