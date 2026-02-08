class Solution:
    def numSplits(self, s: str) -> int:
        n = len(s)

        # left_distinct[i] stores the number of distinct characters in s[0...i]
        left_distinct = [0] * n
        current_set = set()
        for i in range(n):
            current_set.add(s[i])
            left_distinct[i] = len(current_set)

        # right_distinct[i] stores the number of distinct characters in s[i...n-1]
        right_distinct = [0] * n
        current_set = set()
        for i in range(n - 1, -1, -1):
            current_set.add(s[i])
            right_distinct[i] = len(current_set)

        good_splits = 0
        # A split at index i means left part is s[0...i] and right part is s[i+1...n-1]
        # We need to compare distinct count of s[0...i] with distinct count of s[i+1...n-1]
        # The split point `i` can go from 0 to n-2 (to ensure right part has at least 1 char)
        for i in range(n - 1):
            if left_distinct[i] == right_distinct[i+1]:
                good_splits += 1

        return good_splits