class Solution:
    def minimumSteps(self, s: str) -> int:
        res = 0
        white_pos = 0

        for i, char in enumerate(s):
            if char == '0':
                res += i - white_pos
                white_pos += 1

        return res