class Solution:
    def maxLengthBetweenEqualCharacters(self, s: str) -> int:
        index_map = {}
        max_length = -1

        for i, char in enumerate(s):
            if char in index_map:
                max_length = max(max_length, i - index_map[char] - 1)
            else:
                index_map[char] = i

        return max_length