class Solution:
    def smallestPalindromic(self, n: str) -> str:
        from collections import Counter

        count = Counter(n)
        odd_count = sum(1 for v in count.values() if v % 2)

        if odd_count > 1 or (len(count) == 1 and list(count.values())[0] == 1):
            return ""

        half = []
        middle = ""

        for k in sorted(count.keys()):
            if count[k] % 2 == 1:
                middle = k
            half.append(k * (count[k] // 2))

        half = ''.join(half)
        smallest_palindrome = half + middle + half[::-1]

        return smallest_palindrome if smallest_palindrome[0] != '0' else smallest_palindrome[1:]