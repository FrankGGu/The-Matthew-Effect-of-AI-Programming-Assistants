class Solution:
    def numSplits(self, s: str) -> int:
        n = len(s)
        left_count = {}
        right_count = {}

        for char in s:
            if char in right_count:
                right_count[char] += 1
            else:
                right_count[char] = 1

        good_splits = 0
        for i in range(n - 1):
            char = s[i]
            if char in left_count:
                left_count[char] += 1
            else:
                left_count[char] = 1

            right_count[char] -= 1
            if right_count[char] == 0:
                del right_count[char]

            if len(left_count) == len(right_count):
                good_splits += 1

        return good_splits