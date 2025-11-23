class Solution:
    def addBinary(self, a: str, b: str) -> str:
        carry = 0
        result = []
        i = len(a) - 1
        j = len(b) - 1

        while i >= 0 or j >= 0 or carry:
            sum_val = carry
            if i >= 0:
                sum_val += int(a[i])
                i -= 1
            if j >= 0:
                sum_val += int(b[j])
                j -= 1
            result.append(str(sum_val % 2))
            carry = sum_val // 2

        return ''.join(reversed(result))