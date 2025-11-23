class Solution:
    def balancedString(self, s: str) -> int:
        n = len(s)
        k = n // 4
        count = {'Q': 0, 'W': 0, 'E': 0, 'R': 0}
        for char in s:
            count[char] += 1

        need = {}
        for char in count:
            if count[char] > k:
                need[char] = count[char] - k

        if not need:
            return 0

        l, r = 0, 0
        min_len = n
        window = {'Q': 0, 'W': 0, 'E': 0, 'R': 0}

        while r < n:
            window[s[r]] += 1

            while all(window[char] >= need.get(char, 0) for char in 'QWER'):
                min_len = min(min_len, r - l + 1)
                window[s[l]] -= 1
                l += 1

            r += 1

        return min_len