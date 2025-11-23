class Solution:
    def shiftingLetters(self, s: str, shifts: List[int]) -> str:
        total_shift = 0
        res = []
        for i in range(len(shifts)-1, -1, -1):
            total_shift += shifts[i]
            res.append(chr((ord(s[i]) - ord('a') + total_shift) % 26 + ord('a')))
        return ''.join(reversed(res))