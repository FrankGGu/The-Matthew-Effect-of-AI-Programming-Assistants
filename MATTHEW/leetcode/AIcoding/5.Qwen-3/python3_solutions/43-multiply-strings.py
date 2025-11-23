class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        if num1 == "0" or num2 == "0":
            return "0"

        len1, len2 = len(num1), len(num2)
        result = [0] * (len1 + len2)

        num1 = num1[::-1]
        num2 = num2[::-1]

        for i in range(len1):
            digit1 = int(num1[i])
            for j in range(len2):
                digit2 = int(num2[j])
                product = digit1 * digit2
                result[i + j] += product
                result[i + j + 1] += result[i + j] // 10
                result[i + j] %= 10

        while len(result) > 1 and result[-1] == 0:
            result.pop()

        return ''.join(str(digit) for digit in reversed(result))