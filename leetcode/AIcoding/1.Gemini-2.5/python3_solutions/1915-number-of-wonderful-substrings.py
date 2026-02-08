class Solution:
    def wonderfulSubstrings(self, word: str) -> int:
        count = [0] * (1 << 10)  # Stores frequency of each prefix mask
        count[0] = 1  # Empty prefix has mask 0, occurs once

        current_mask = 0
        wonderful_count = 0

        for char_code in word:
            # Update the current mask by flipping the bit for the current character
            current_mask ^= (1 << (ord(char_code) - ord('a')))

            # Case 1: All characters in the substring appear an even number of times.
            # This means current_mask == previous_mask.
            wonderful_count += count[current_mask]

            # Case 2: Exactly one character in the substring appears an odd number of times.
            # This means current_mask ^ previous_mask has exactly one bit set.
            # We iterate through all possible single-bit differences (0 to 9)
            for i in range(10):
                target_mask = current_mask ^ (1 << i)
                wonderful_count += count[target_mask]

            # Increment the frequency of the current mask
            count[current_mask] += 1

        return wonderful_count