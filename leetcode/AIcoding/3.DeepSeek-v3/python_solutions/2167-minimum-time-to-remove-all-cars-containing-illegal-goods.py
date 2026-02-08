class Solution:
    def minimumTime(self, s: str) -> int:
        n = len(s)
        left = [0] * n
        left[0] = 1 if s[0] == '1' else 0
        for i in range(1, n):
            if s[i] == '1':
                left[i] = min(left[i-1] + 2, i + 1)
            else:
                left[i] = left[i-1]

        right = [0] * n
        right[-1] = 1 if s[-1] == '1' else 0
        for i in range(n-2, -1, -1):
            if s[i] == '1':
                right[i] = min(right[i+1] + 2, n - i)
            else:
                right[i] = right[i+1]

        res = min(left[-1], right[0])
        for i in range(n-1):
            res = min(res, left[i] + right[i+1])

        return res