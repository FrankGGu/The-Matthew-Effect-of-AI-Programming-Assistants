class Solution:
    def findTheLongestSubstring(self, s: str) -> int:
        vowel_indices = {'a': 1, 'e': 2, 'i': 4, 'o': 8, 'u': 16}
        state = 0
        index_map = {0: -1}
        max_length = 0

        for i, char in enumerate(s):
            if char in vowel_indices:
                state ^= vowel_indices[char]
            if state not in index_map:
                index_map[state] = i
            else:
                max_length = max(max_length, i - index_map[state])

        return max_length