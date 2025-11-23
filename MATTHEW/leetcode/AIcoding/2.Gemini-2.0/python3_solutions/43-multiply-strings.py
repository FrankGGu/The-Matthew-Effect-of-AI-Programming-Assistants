class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        if num1 == "0" or num2 == "0":
            return "0"

        m, n = len(num1), len(num2)
        product = [0] * (m + n)

        for i in range(m - 1, -1, -1):
            carry = 0
            for j in range(n - 1, -1, -1):
                product[i + j + 1] += int(num1[i]) * int(num2[j]) + carry
                carry = product[i + j + 1] // 10
                product[i + j + 1] %= 10
            product[i] += carry

        result = "".join(map(str, product))

        while result[0] == '0' and len(result) > 1:
            result = result[1:]

        return result