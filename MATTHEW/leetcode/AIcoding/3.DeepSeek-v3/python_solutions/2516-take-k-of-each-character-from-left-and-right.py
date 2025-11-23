class Solution:
    def takeCharacters(self, s: str, k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for c in s:
            count[c] += 1

        if any(count[c] < k for c in 'abc'):
            return -1

        res = float('inf')
        left = 0
        n = len(s)

        for right in range(n):
            count[s[right]] -= 1

            while count[s[right]] < k:
                count[s[left]] += 1
                left += 1

            res = min(res, (n - (right - left + 1)))

        return res