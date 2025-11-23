class Solution:
    def checkBalancedString(self, s: str) -> int:
        n = len(s)
        k = n // 4
        count = {'Q': 0, 'W': 0, 'E': 0, 'R': 0}
        for char in s:
            count[char] += 1

        excess = {}
        for char in count:
            if count[char] > k:
                excess[char] = count[char] - k

        if not excess:
            return 0

        l, r = 0, 0
        min_len = n

        curr = {'Q': 0, 'W': 0, 'E': 0, 'R': 0}

        while r < n:
            curr[s[r]] += 1

            while all(curr.get(char, 0) >= excess.get(char, 0) for char in 'QWER'):
                min_len = min(min_len, r - l + 1)
                curr[s[l]] -= 1
                l += 1

            r += 1

        return min_len