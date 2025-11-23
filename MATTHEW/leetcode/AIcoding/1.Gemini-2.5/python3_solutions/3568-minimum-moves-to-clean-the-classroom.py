class Solution:
    def minimumMoves(self, s: str, k: int) -> int:
        n = len(s)
        moves = 0
        i = 0
        while i < n:
            if s[i] == 'D':
                moves += 1
                i += k
            else:
                i += 1
        return moves