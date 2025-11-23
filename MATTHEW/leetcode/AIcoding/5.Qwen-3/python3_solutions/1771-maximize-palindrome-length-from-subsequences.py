class Solution:
    def maxPalindrome(self, s: str) -> int:
        from collections import Counter

        count = Counter(s)
        odd_count = 0
        for c in count:
            if count[c] % 2 == 1:
                odd_count += 1

        return len(s) - max(0, odd_count - 1)