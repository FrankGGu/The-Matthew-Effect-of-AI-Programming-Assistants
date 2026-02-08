class Solution:
    def findTheLongestSubstring(self, s: str) -> int:
        vowels = {'a': 1, 'e': 2, 'i': 4, 'o': 8, 'u': 16}
        state = 0
        first_occurrence = {0: -1}
        max_len = 0
        for i, char in enumerate(s):
            if char in vowels:
                state ^= vowels[char]
            if state not in first_occurrence:
                first_occurrence[state] = i
            else:
                max_len = max(max_len, i - first_occurrence[state])
        return max_len