class Solution:
    def numSplits(self, s: str) -> int:
        left_count = [0] * (len(s) + 1)
        right_count = [0] * (len(s) + 1)

        unique_left = set()
        unique_right = set()

        for i in range(len(s)):
            unique_left.add(s[i])
            left_count[i + 1] = len(unique_left)

        for i in range(len(s) - 1, -1, -1):
            unique_right.add(s[i])
            right_count[i] = len(unique_right)

        good_splits = 0
        for i in range(1, len(s)):
            if left_count[i] == right_count[i]:
                good_splits += 1

        return good_splits