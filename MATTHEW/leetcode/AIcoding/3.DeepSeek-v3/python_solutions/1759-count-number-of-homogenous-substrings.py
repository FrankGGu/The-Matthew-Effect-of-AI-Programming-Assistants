class Solution:
    def countHomogenous(self, s: str) -> int:
        MOD = 10**9 + 7
        res = 0
        current_char = ''
        current_length = 0

        for char in s:
            if char == current_char:
                current_length += 1
            else:
                current_char = char
                current_length = 1
            res = (res + current_length) % MOD

        return res