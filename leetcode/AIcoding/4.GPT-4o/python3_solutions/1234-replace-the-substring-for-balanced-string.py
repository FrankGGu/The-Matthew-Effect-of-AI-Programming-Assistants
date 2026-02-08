class Solution:
    def balancedString(self, s: str) -> int:
        count = Counter(s)
        n = len(s)
        target = n // 4
        if all(count[c] == target for c in 'QWER'):
            return 0

        left = 0
        min_len = n
        for right in range(n):
            count[s[right]] -= 1
            while all(count[c] <= target for c in 'QWER'):
                min_len = min(min_len, right - left + 1)
                count[s[left]] += 1
                left += 1
        return min_len