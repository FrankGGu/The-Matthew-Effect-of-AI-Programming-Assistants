import collections

class Solution:
    def countVowelSubstrings(self, s: str) -> int:
        vowels_set = {'a', 'e', 'i', 'o', 'u'}
        vowel_to_idx = {'a': 0, 'e': 1, 'i': 2, 'o': 3, 'u': 4}
        n = len(s)
        ans = 0

        left_block = 0  # Start of the current contiguous block of only vowels
        left_vowel_min = 0  # Start of the smallest window within [left_block, right] that contains all 5 distinct vowels

        vowel_freq = [0] * 5
        distinct_vowels = 0

        for right in range(n):
            char_r = s[right]

            if char_r not in vowels_set:
                # If a consonant is encountered, reset the block and counts
                left_block = right + 1
                left_vowel_min = right + 1
                vowel_freq = [0] * 5
                distinct_vowels = 0
                continue

            # If char_r is a vowel, add it to the current window [left_vowel_min, right]
            idx_r = vowel_to_idx[char_r]
            if vowel_freq[idx_r] == 0:
                distinct_vowels += 1
            vowel_freq[idx_r] += 1

            # While the window [left_vowel_min, right] contains all 5 distinct vowels,
            # we can form valid substrings.
            while distinct_vowels == 5:
                # All substrings s[L...right] where left_block <= L <= left_vowel_min
                # are valid (contain only vowels and all 5 distinct vowels).
                # The number of such L's is (left_vowel_min - left_block + 1).
                ans += (left_vowel_min - left_block + 1)

                # Try to shrink the window from left_vowel_min
                char_l = s[left_vowel_min]
                idx_l = vowel_to_idx[char_l]

                vowel_freq[idx_l] -= 1
                if vowel_freq[idx_l] == 0:
                    distinct_vowels -= 1 # This removal breaks the 'all 5 vowels' condition

                left_vowel_min += 1

        return ans