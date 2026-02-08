class Solution:
    def minimizeXor(self, num1: int, num2: int) -> int:
        count = bin(num2).count('1')
        num1_bits = bin(num1)[2:]
        res = ['0'] * len(num1_bits) if num1 != 0 else ['0']

        if num1 == 0:
            return 0 if count == 0 else (1 << (count - 1))

        n = len(num1_bits)
        positions = []

        for i in range(n):
            if num1_bits[i] == '1':
                positions.append(i)

        for i in range(min(count, len(positions))):
            res[positions[i]] = '1'

        remaining = count - len(positions)
        if remaining > 0:
            res = ['0'] * (n + remaining)
            for i in range(remaining):
                res[-1 - i] = '1'
            for pos in positions:
                if pos < len(res):
                    res[pos] = '1'
                else:
                    res = ['1'] + res
                    res[pos + 1] = '1'
        elif remaining < 0:
            for i in range(len(positions) - 1, len(positions) - 1 + remaining, -1):
                res[positions[i]] = '0'

        return int(''.join(res), 2)