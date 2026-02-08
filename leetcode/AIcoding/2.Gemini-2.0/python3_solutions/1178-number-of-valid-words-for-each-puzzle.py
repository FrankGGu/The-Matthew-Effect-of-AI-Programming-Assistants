from collections import defaultdict

class Solution:
    def findNumOfValidWords(self, words: list[str], puzzles: list[str]) -> list[int]:
        word_counts = defaultdict(int)
        for word in words:
            mask = 0
            for char in word:
                mask |= (1 << (ord(char) - ord('a')))
            if bin(mask).count('1') <= 7:
                word_counts[mask] += 1

        result = []
        for puzzle in puzzles:
            first_char = puzzle[0]
            first_bit = 1 << (ord(first_char) - ord('a'))

            count = 0

            submask = 0
            puzzle_mask = 0
            for char in puzzle:
                puzzle_mask |= (1 << (ord(char) - ord('a')))

            submask = puzzle_mask
            while True:
                if submask & first_bit:
                    count += word_counts[submask]

                if submask == 0:
                    break

                submask = (submask - 1) & puzzle_mask

            result.append(count)

        return result