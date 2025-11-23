import collections

class Solution:
    def findNumOfValidWords(self, words: list[str], puzzles: list[str]) -> list[int]:
        word_masks_counts = collections.Counter()

        for word in words:
            mask = 0
            for char_code in map(ord, word):
                mask |= (1 << (char_code - ord('a')))
            word_masks_counts[mask] += 1

        results = []

        for puzzle in puzzles:
            p_mask = 0
            for char_code in map(ord, puzzle):
                p_mask |= (1 << (char_code - ord('a')))

            first_char_bit = (1 << (ord(puzzle[0]) - ord('a')))

            current_puzzle_valid_words_count = 0

            sub_mask = p_mask
            while True:
                if sub_mask in word_masks_counts:
                    if (sub_mask & first_char_bit) == first_char_bit:
                        current_puzzle_valid_words_count += word_masks_counts[sub_mask]

                if sub_mask == 0:
                    break

                sub_mask = (sub_mask - 1) & p_mask

            results.append(current_puzzle_valid_words_count)

        return results