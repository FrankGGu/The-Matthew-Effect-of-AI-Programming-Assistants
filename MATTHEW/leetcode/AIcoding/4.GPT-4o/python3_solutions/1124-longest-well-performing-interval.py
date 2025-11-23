class Solution:
    def longestWPI(self, hours: List[int]) -> int:
        n = len(hours)
        prefix = [0] * (n + 1)

        for i in range(n):
            prefix[i + 1] = prefix[i] + (1 if hours[i] > 8 else -1)

        stack = []
        max_length = 0

        for i in range(n + 1):
            if not stack or prefix[stack[-1]] > prefix[i]:
                stack.append(i)

        for i in range(n, -1, -1):
            while stack and prefix[stack[-1]] < prefix[i]:
                max_length = max(max_length, i - stack.pop())

        return max_length