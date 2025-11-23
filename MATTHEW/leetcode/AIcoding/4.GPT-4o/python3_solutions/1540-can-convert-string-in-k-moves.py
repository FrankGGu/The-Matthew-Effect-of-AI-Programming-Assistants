class Solution:
    def canConvertString(self, s: str, t: str, k: int) -> bool:
        if len(s) != len(t):
            return False

        moves_needed = {}

        for i in range(len(s)):
            if s[i] != t[i]:
                move = (ord(t[i]) - ord(s[i])) % 26
                if move == 0:
                    continue
                if move in moves_needed:
                    moves_needed[move] += 1
                else:
                    moves_needed[move] = 1

        for move, count in moves_needed.items():
            if move * count > k or (move * count > k and move * (count - 1) > k):
                return False

        return True