class Solution:
    def shiftingLetters(self, s: str, shifts: List[List[int]]) -> str:
        n = len(s)
        diff = [0] * (n + 1)

        for start, end, direction in shifts:
            delta = 1 if direction == 1 else -1
            diff[start] += delta
            if end + 1 < n:
                diff[end + 1] -= delta

        current_shift = 0
        result = []
        for i in range(n):
            current_shift += diff[i]
            original = ord(s[i]) - ord('a')
            shifted = (original + current_shift) % 26
            result.append(chr(shifted + ord('a')))

        return ''.join(result)