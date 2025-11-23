from collections import defaultdict

class Solution:
    def smallestPalindrome(self, s: str) -> str:
        count = defaultdict(int)
        for char in s:
            count[char] += 1

        odd_char = ''
        half = []
        for char in sorted(count.keys()):
            cnt = count[char]
            if cnt % 2 == 1:
                if not odd_char:
                    odd_char = char
                cnt -= 1
            half.extend([char] * (cnt // 2))

        palindrome = ''.join(half) + odd_char + ''.join(reversed(half))
        return palindrome