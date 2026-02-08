class Solution:
    def minMovesToMakePalindrome(self, s: str) -> int:
        from collections import Counter

        count = Counter(s)
        odd_count = sum(1 for v in count.values() if v % 2 != 0)

        if odd_count > 1:
            return -1

        n = len(s)
        moves = 0
        s = list(s)

        while s:
            if s[0] == s[-1]:
                s.pop(0)
                s.pop()
            else:
                left = s.index(s[-1])
                moves += left
                s.pop(left)
                s.pop()

        return moves