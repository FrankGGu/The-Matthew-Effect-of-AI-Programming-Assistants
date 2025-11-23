class Solution:
    def sortVowels(self, s: str) -> str:
        vowels = sorted([c for c in s if c in 'aeiouAEIOU'])
        result = []
        vowel_index = 0

        for c in s:
            if c in 'aeiouAEIOU':
                result.append(vowels[vowel_index])
                vowel_index += 1
            else:
                result.append(c)

        return ''.join(result)