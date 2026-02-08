import collections

class Solution:
    def maxRepOpt1(self, text: str) -> int:
        char_counts = collections.Counter(text)

        blocks = []
        if not text:
            return 0

        current_char = text[0]
        current_len = 0
        for char in text:
            if char == current_char:
                current_len += 1
            else:
                blocks.append((current_char, current_len))
                current_char = char
                current_len = 1
        blocks.append((current_char, current_len))

        max_len = 0

        # Case 1: Consider each block individually.
        # If there's a spare character of the same type elsewhere in the string,
        # we can swap it to extend this block by 1.
        for char, length in blocks:
            if char_counts[char] > length:
                max_len = max(max_len, length + 1)
            else: # All occurrences of 'char' are within this block, no spare to swap.
                max_len = max(max_len, length)

        # Case 2: Consider merging two blocks of the same character
        # if they are separated by exactly one different character.
        # Pattern: (char_A, len1), (char_B, 1), (char_A, len2)
        for i in range(2, len(blocks)):
            # Check if blocks[i-2] and blocks[i] are of the same character
            # and blocks[i-1] is a single character block.
            if blocks[i-2][0] == blocks[i][0] and blocks[i-1][1] == 1:
                c = blocks[i-2][0]
                l1 = blocks[i-2][1]
                l2 = blocks[i][1]

                # The potential length if we merge them is l1 + l2.
                # If there's a spare 'c' character (meaning char_counts[c] > l1 + l2),
                # we can swap it with the middle character to form a block of length l1 + l2 + 1.
                # If there's no spare 'c' (char_counts[c] == l1 + l2),
                # we can still swap one 'c' from either l1 or l2 with the middle character,
                # effectively just moving a 'c' to fill the gap, resulting in length l1 + l2.
                # The expression min(char_counts[c], l1 + l2 + 1) correctly captures both scenarios:
                # it's l1 + l2 + 1 if char_counts[c] is large enough,
                # otherwise it's limited by char_counts[c] (which would be l1 + l2 in the second case).
                max_len = max(max_len, min(char_counts[c], l1 + l2 + 1))

        return max_len