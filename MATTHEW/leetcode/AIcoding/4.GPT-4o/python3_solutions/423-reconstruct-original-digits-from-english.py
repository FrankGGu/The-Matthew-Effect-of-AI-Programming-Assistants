class Solution:
    def originalDigits(self, s: str) -> str:
        count = [0] * 10
        for char in s:
            if char == 'z':
                count[0] += 1
            elif char == 'w':
                count[2] += 1
            elif char == 'u':
                count[4] += 1
            elif char == 'x':
                count[6] += 1
            elif char == 'g':
                count[8] += 1
            elif char == 'o':
                count[1] += 1
            elif char == 'h':
                count[3] += 1
            elif char == 'f':
                count[5] += 1
            elif char == 's':
                count[7] += 1
            elif char == 'i':
                count[9] += 1

        count[1] -= count[0] + count[2] + count[4]
        count[3] -= count[8]
        count[5] -= count[4]
        count[7] -= count[6]
        count[9] -= count[5] + count[6] + count[8]

        result = []
        for i in range(10):
            result.append(str(i) * count[i])

        return ''.join(result)