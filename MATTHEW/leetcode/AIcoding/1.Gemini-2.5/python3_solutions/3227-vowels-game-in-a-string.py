class Solution:
    def vowelsGame(self, s: str) -> bool:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        vowel_count = 0
        for char in s:
            if char in vowels:
                vowel_count += 1

        return vowel_count % 2 == 1