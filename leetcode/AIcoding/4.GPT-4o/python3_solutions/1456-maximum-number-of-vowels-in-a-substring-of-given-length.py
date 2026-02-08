class Solution:
    def maxVowels(self, s: str, k: int) -> int:
        vowels = set('aeiou')
        max_count = 0
        current_count = 0

        for i in range(len(s)):
            if s[i] in vowels:
                current_count += 1
            if i >= k:
                if s[i - k] in vowels:
                    current_count -= 1
            if i >= k - 1:
                max_count = max(max_count, current_count)

        return max_count