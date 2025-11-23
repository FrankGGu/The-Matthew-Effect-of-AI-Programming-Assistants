class Solution:
    def findNumOfValidWords(self, words: List[str], puzzles: List[str]) -> List[int]:
        freq = {}
        for word in words:
            mask = 0
            for c in word:
                mask |= 1 << (ord(c) - ord('a'))
            freq[mask] = freq.get(mask, 0) + 1

        res = []
        for puzzle in puzzles:
            total = 0
            mask = 0
            for c in puzzle[1:]:
                mask |= 1 << (ord(c) - ord('a'))
            subset = mask
            while True:
                s = subset | (1 << (ord(puzzle[0]) - ord('a')))
                if s in freq:
                    total += freq[s]
                if subset == 0:
                    break
                subset = (subset - 1) & mask
            res.append(total)
        return res