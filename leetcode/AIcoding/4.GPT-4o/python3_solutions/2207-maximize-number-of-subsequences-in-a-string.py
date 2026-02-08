class Solution:
    def maximumSubsequenceCount(self, text: str, pattern: str) -> int:
        count_pattern = text.count(pattern)
        count_first = text.count(pattern[0])
        count_second = text.count(pattern[1])

        if pattern[0] == pattern[1]:
            return count_pattern + count_first

        return count_pattern + max(count_first, count_second)