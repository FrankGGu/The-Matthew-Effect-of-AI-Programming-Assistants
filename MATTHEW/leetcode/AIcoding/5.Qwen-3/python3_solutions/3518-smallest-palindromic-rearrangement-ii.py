class Solution:
    def makePalindrome(self, s: str) -> str:
        from collections import Counter

        count = Counter(s)
        half = []
        mid = ''

        for c in count:
            if count[c] % 2 == 1:
                mid = c
                count[c] -= 1
            half.extend([c] * (count[c] // 2))

        half.sort()
        left = ''.join(half)
        right = left[::-1]

        return left + mid + right