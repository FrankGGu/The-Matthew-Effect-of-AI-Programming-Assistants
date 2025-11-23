class Solution:
    def takeCharacters(self, s: str) -> int:
        from collections import Counter

        count = Counter(s)
        n = len(s)
        left = 0
        right = n - 1
        res = float('inf')

        while left <= right:
            if count[s[left]] > 1:
                count[s[left]] -= 1
                left += 1
            elif count[s[right]] > 1:
                count[s[right]] -= 1
                right -= 1
            else:
                break

        for i in range(n):
            if count[s[i]] == 0:
                res = min(res, i)
                break

        for i in range(n - 1, -1, -1):
            if count[s[i]] == 0:
                res = min(res, n - i - 1)
                break

        return res if res != float('inf') else n