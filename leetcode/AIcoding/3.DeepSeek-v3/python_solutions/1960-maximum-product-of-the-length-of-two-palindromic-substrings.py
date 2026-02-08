class Solution:
    def maxProduct(self, s: str) -> int:
        n = len(s)
        max_len = [0] * n
        center = 0
        right = 0

        for i in range(n):
            if i < right:
                mirror = 2 * center - i
                max_len[i] = min(right - i, max_len[mirror])
            else:
                max_len[i] = 0

            l = i - max_len[i] - 1
            r = i + max_len[i] + 1
            while l >= 0 and r < n and s[l] == s[r]:
                max_len[i] += 1
                l -= 1
                r += 1

            if i + max_len[i] > right:
                center = i
                right = i + max_len[i]

        left_max = [0] * n
        max_so_far = 0
        for i in range(n):
            max_so_far = max(max_so_far, 2 * max_len[i] + 1)
            left_max[i] = max_so_far

        right_max = [0] * n
        max_so_far = 0
        for i in range(n-1, -1, -1):
            max_so_far = max(max_so_far, 2 * max_len[i] + 1)
            right_max[i] = max_so_far

        res = 0
        for i in range(n-1):
            res = max(res, left_max[i] * right_max[i+1])

        return res