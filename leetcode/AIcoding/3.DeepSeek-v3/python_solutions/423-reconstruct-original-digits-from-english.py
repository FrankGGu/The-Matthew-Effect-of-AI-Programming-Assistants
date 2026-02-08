class Solution:
    def originalDigits(self, s: str) -> str:
        count = [0] * 10
        char_count = {}
        for c in s:
            char_count[c] = char_count.get(c, 0) + 1

        # Unique cases
        count[0] = char_count.get('z', 0)
        count[2] = char_count.get('w', 0)
        count[4] = char_count.get('u', 0)
        count[6] = char_count.get('x', 0)
        count[8] = char_count.get('g', 0)

        # Derived cases
        count[3] = char_count.get('h', 0) - count[8]
        count[5] = char_count.get('f', 0) - count[4]
        count[7] = char_count.get('s', 0) - count[6]
        count[9] = char_count.get('i', 0) - count[5] - count[6] - count[8]
        count[1] = char_count.get('o', 0) - count[0] - count[2] - count[4]

        result = []
        for i in range(10):
            result.append(str(i) * count[i])

        return ''.join(result)