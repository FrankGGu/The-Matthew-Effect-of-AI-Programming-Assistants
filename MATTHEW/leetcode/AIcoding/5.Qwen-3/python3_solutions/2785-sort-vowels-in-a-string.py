class Solution:
    def sortVowels(self, s: str) -> str:
        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
        vowels_in_s = [c for c in s if c in vowels]
        vowels_in_s.sort()
        result = []
        index = 0
        for c in s:
            if c in vowels:
                result.append(vowels_in_s[index])
                index += 1
            else:
                result.append(c)
        return ''.join(result)