class Solution:
    def maxVowels(self, s: str, k: int) -> int:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        max_vowels = current = sum(1 for c in s[:k] if c in vowels)

        for i in range(k, len(s)):
            current += (s[i] in vowels) - (s[i - k] in vowels)
            if current > max_vowels:
                max_vowels = current
                if max_vowels == k:
                    break

        return max_vowels