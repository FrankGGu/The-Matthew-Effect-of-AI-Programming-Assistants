class Solution:
    def countPalindromicSubsequence(self, s: str) -> int:
        first = {}
        last = {}

        for i, char in enumerate(s):
            if char not in first:
                first[char] = i
            last[char] = i

        unique_palindromes = set()

        for char in first:
            if first[char] < last[char]:
                for middle_char in set(s[first[char] + 1:last[char]]):
                    unique_palindromes.add(char + middle_char + char)

        return len(unique_palindromes)