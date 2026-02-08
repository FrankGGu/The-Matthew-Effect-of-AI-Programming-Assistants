from collections import defaultdict
from itertools import combinations

class Solution:
    def findNumOfValidWords(self, words: List[str], puzzles: List[str]) -> List[int]:
        count = defaultdict(int)
        for word in words:
            mask = 0
            for char in set(word):
                mask |= 1 << (ord(char) - ord('a'))
            count[mask] += 1

        result = []
        for puzzle in puzzles:
            first_char_mask = 1 << (ord(puzzle[0]) - ord('a'))
            valid_count = 0
            for i in range(1 << 6):
                if first_char_mask & i:
                    mask = 0
                    for j in range(7):
                        if i & (1 << j):
                            mask |= 1 << (ord(puzzle[j + 1]) - ord('a'))
                    valid_count += count[mask]
            result.append(valid_count)

        return result