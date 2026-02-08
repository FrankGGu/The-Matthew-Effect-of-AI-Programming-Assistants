class Solution:
    def transformedString(self, s: str) -> int:
        def count_characters(s, transformations):
            count = 0
            for char in s:
                count += transformations.get(char, 1)
            return count

        transformations = {}
        for i in range(len(s)):
            transformations[s[i]] = transformations.get(s[i], 0) + 1

        total_count = count_characters(s, transformations)
        return total_count