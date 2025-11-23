from collections import Counter

class Solution:
    def isScramble(self, s1: str, s2: str) -> bool:
        memo = {}

        def solve(sub1: str, sub2: str) -> bool:
            if (sub1, sub2) in memo:
                return memo[(sub1, sub2)]

            if sub1 == sub2:
                memo[(sub1, sub2)] = True
                return True

            n = len(sub1)
            if n == 1:
                memo[(sub1, sub2)] = (sub1[0] == sub2[0])
                return memo[(sub1, sub2)]

            # Optimization: check character counts.
            # If character counts are different, they cannot be scrambled.
            if Counter(sub1) != Counter(sub2):
                memo[(sub1, sub2)] = False
                return False

            for i in range(1, n): # i is the split point, length of the first part (from 1 to n-1)
                # Case 1: No swap
                # s1 is split into sub1[:i] and sub1[i:]
                # s2 is split into sub2[:i] and sub2[i:]
                if solve(sub1[:i], sub2[:i]) and solve(sub1[i:], sub2[i:]):
                    memo[(sub1, sub2)] = True
                    return True

                # Case 2: Swap
                # s1 is split into sub1[:i] and sub1[i:]
                # s2 is split into sub2[n-i:] (last i chars) and sub2[:n-i] (first n-i chars)
                if solve(sub1[:i], sub2[n-i:]) and solve(sub1[i:], sub2[:n-i]):
                    memo[(sub1, sub2)] = True
                    return True

            memo[(sub1, sub2)] = False
            return False

        return solve(s1, s2)