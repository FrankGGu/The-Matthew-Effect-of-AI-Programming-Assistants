class Solution:
    def longestBeautifulSubstring(self, word: str) -> int:
        vowels = "aeiou"
        n = len(word)
        max_len = 0
        i = 0
        while i < n:
            if word[i] == 'a':
                start = i
                curr_vowel_index = 0
                while i < n and word[i] in vowels:
                    if vowels[curr_vowel_index] == word[i]:
                        while i < n and vowels[curr_vowel_index] == word[i]:
                            i += 1
                        curr_vowel_index += 1
                    else:
                        break
                if curr_vowel_index == 5:
                    max_len = max(max_len, i - start)
            else:
                i += 1
        return max_len