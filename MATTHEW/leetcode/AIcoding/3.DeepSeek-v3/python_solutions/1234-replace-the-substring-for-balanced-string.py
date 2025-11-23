class Solution:
    def balancedString(self, s: str) -> int:
        count = collections.Counter(s)
        res = n = len(s)
        left = 0
        target = n // 4

        for right, char in enumerate(s):
            count[char] -= 1
            while left < n and all(count[c] <= target for c in 'QWER'):
                res = min(res, right - left + 1)
                count[s[left]] += 1
                left += 1

        return res