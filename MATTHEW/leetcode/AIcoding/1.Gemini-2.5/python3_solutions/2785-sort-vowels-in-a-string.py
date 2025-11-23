class Solution:
    def sortVowels(self, s: str) -> str:
        vowels_set = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}

        collected_vowels = []
        for char in s:
            if char in vowels_set:
                collected_vowels.append(char)

        collected_vowels.sort()

        result_chars = []
        vowel_ptr = 0

        for char_s in s:
            if char_s in vowels_set:
                result_chars.append(collected_vowels[vowel_ptr])
                vowel_ptr += 1
            else:
                result_chars.append(char_s)

        return "".join(result_chars)