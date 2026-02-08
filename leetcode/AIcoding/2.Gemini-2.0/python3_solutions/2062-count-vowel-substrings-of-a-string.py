class Solution:
    def countVowelSubstrings(self, word: str) -> int:
        vowels = "aeiou"
        count = 0
        for i in range(len(word)):
            for j in range(i, len(word)):
                substring = word[i:j+1]
                vowel_only = True
                for char in substring:
                    if char not in vowels:
                        vowel_only = False
                        break
                if vowel_only and len(set(substring)) == 5:
                    count += 1
        return count