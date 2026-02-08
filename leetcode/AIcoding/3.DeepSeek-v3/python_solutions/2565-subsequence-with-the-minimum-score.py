class Solution:
    def minimumScore(self, s: str, t: str) -> int:
        m, n = len(s), len(t)
        left = [n] * (m + 1)
        left[0] = 0
        for i in range(1, m + 1):
            if left[i - 1] < n and s[i - 1] == t[left[i - 1]]:
                left[i] = left[i - 1] + 1
            else:
                left[i] = left[i - 1]

        right = [0] * (m + 1)
        right[m] = n
        for i in range(m - 1, -1, -1):
            if right[i + 1] > 0 and s[i] == t[right[i + 1] - 1]:
                right[i] = right[i + 1] - 1
            else:
                right[i] = right[i + 1]

        min_score = n
        for i in range(m + 1):
            if left[i] >= right[i]:
                min_score = 0
                break
            min_score = min(min_score, right[i] - left[i])

        return min_score