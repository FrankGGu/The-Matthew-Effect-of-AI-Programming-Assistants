class Solution:
    def minimumTime(self, s: str) -> int:
        n = len(s)
        left = [0] * n
        right = [0] * n

        for i in range(n):
            if s[i] == '0':
                left[i] = left[i - 1] if i > 0 else 0
            else:
                left[i] = (left[i - 1] if i > 0 else 0) + 1

        for i in range(n - 1, -1, -1):
            if s[i] == '0':
                right[i] = right[i + 1] if i < n - 1 else 0
            else:
                right[i] = (right[i + 1] if i < n - 1 else 0) + 1

        res = float('inf')
        for i in range(n):
            total = left[i] + right[i]
            if i > 0:
                total += left[i - 1]
            if i < n - 1:
                total += right[i + 1]
            res = min(res, total)

        return res