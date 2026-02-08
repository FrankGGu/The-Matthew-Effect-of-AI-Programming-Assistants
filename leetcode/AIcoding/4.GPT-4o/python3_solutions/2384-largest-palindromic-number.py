class Solution:
    def largestPalindromic(self, num: str) -> str:
        count = [0] * 10
        for digit in num:
            count[int(digit)] += 1

        half = []
        middle = ''

        for i in range(9, -1, -1):
            if count[i] > 0:
                half.append(str(i) * (count[i] // 2))
                if count[i] % 2 == 1 and middle == '':
                    middle = str(i)

        half_str = ''.join(half)
        if half_str == '' and middle == '':
            return '0'
        elif half_str == '':
            return middle

        result = half_str + middle + half_str[::-1]
        return result.lstrip('0') or '0'