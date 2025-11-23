class Solution:
    def originalDigits(self, s: str) -> str:
        counts = {}
        for char in s:
            counts[char] = counts.get(char, 0) + 1

        digits = [0] * 10
        digits[0] = counts.get('z', 0)
        digits[2] = counts.get('w', 0)
        digits[4] = counts.get('u', 0)
        digits[6] = counts.get('x', 0)
        digits[8] = counts.get('g', 0)

        digits[1] = counts.get('o', 0) - digits[0] - digits[2] - digits[4]
        digits[3] = counts.get('h', 0) - digits[8]
        digits[5] = counts.get('f', 0) - digits[4]
        digits[7] = counts.get('v', 0) - digits[5]
        digits[9] = counts.get('i', 0) - digits[5] - digits[6] - digits[8]

        result = ""
        for i in range(10):
            result += str(i) * digits[i]

        return result