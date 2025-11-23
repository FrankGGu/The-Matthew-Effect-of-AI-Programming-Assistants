class Solution:
    def findTheLongestSubstring(self, s: str) -> int:
        vowel_map = {'a': 0, 'e': 1, 'i': 2, 'o': 3, 'u': 4}
        mask_to_index = {0: -1}
        current_mask = 0
        max_len = 0

        for i, char in enumerate(s):
            if char in vowel_map:
                current_mask ^= (1 << vowel_map[char])

            if current_mask in mask_to_index:
                max_len = max(max_len, i - mask_to_index[current_mask])
            else:
                mask_to_index[current_mask] = i

        return max_len