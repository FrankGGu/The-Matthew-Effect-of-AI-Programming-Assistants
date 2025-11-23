class Solution:
    def minimumScore(self, s: str, t: str) -> int:
        n, m = len(s), len(t)
        left = [0] * (m + 1)
        j = 0
        for i in range(m):
            if j < n and s[j] == t[i]:
                j += 1
            left[i + 1] = j
        right = [n] * (m + 1)
        j = n - 1
        for i in range(m - 1, -1, -1):
            if j >= 0 and s[j] == t[i]:
                j -= 1
            right[i] = j
        ans = m
        for i in range(m + 1):
            l = i
            r = m
            while l <= r:
                mid = (l + r) // 2
                if left[i] >= right[mid]:
                    ans = min(ans, mid - i)
                    l = mid + 1
                else:
                    r = mid - 1
        return ans