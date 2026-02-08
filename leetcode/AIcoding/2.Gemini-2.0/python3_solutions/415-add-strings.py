class Solution:
    def addStrings(self, num1: str, num2: str) -> str:
        n1 = len(num1)
        n2 = len(num2)
        i = n1 - 1
        j = n2 - 1
        carry = 0
        res = ""
        while i >= 0 or j >= 0 or carry:
            digit1 = int(num1[i]) if i >= 0 else 0
            digit2 = int(num2[j]) if j >= 0 else 0
            sum_digits = digit1 + digit2 + carry
            carry = sum_digits // 10
            res = str(sum_digits % 10) + res
            i -= 1
            j -= 1
        return res