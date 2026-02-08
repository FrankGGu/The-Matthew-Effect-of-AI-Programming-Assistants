class Solution:
    def sortVowels(self, s: str) -> str:
        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
        vowel_list = []
        s_list = list(s)
        for i, char in enumerate(s_list):
            if char in vowels:
                vowel_list.append(char)
        vowel_list.sort()
        idx = 0
        for i, char in enumerate(s_list):
            if char in vowels:
                s_list[i] = vowel_list[idx]
                idx += 1
        return ''.join(s_list)