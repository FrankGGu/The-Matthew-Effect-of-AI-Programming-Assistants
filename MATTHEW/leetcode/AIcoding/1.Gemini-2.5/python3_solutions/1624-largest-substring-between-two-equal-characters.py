class Solution:
    def maxLengthBetweenEqualCharacters(self, s: str) -> int:
        first_occurrence = {}
        max_length = -1

        for i, char in enumerate(s):
            if char in first_occurrence:
                current_length = i - first_occurrence[char] - 1
                max_length = max(max_length, current_length)
            else:
                first_occurrence[char] = i

        return max_length