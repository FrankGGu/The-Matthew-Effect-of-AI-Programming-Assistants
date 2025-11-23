class Solution:
    def countSpecialCharacters(self, s: str, k: int) -> int:
        count = 0
        for i in range(len(s)):
            for j in range(i + 1, len(s) + 1):
                sub = s[i:j]
                freq = {}
                for char in sub:
                    freq[char] = freq.get(char, 0) + 1

                special_chars = 0
                for char in freq:
                    if freq[char] >= k:
                        special_chars += 1

                if special_chars == len(freq):
                    count += 1
        return count