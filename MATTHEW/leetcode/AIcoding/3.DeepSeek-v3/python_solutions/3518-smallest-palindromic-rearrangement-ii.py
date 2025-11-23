from collections import defaultdict

class Solution:
    def smallestPalindrome(self, s: str) -> str:
        count = defaultdict(int)
        for char in s:
            count[char] += 1

        odd_char = ''
        for char in sorted(count.keys()):
            if count[char] % 2 == 1:
                if not odd_char or char < odd_char:
                    odd_char = char

        if not odd_char:
            left = []
            for char in sorted(count.keys()):
                left.extend([char] * (count[char] // 2))
            right = left[::-1]
            return ''.join(left + right)
        else:
            left = []
            count[odd_char] -= 1
            for char in sorted(count.keys()):
                left.extend([char] * (count[char] // 2))
            right = left[::-1]
            return ''.join(left + [odd_char] + right)