class Solution:
    def addBinary(self, a: str, b: str) -> str:
        res = []
        i, j = len(a) - 1, len(b) - 1
        carry = 0

        while i >= 0 or j >= 0 or carry:
            digit_a = int(a[i]) if i >= 0 else 0
            digit_b = int(b[j]) if j >= 0 else 0

            current_sum = digit_a + digit_b + carry
            res.append(str(current_sum % 2))
            carry = current_sum // 2

            i -= 1
            j -= 1

        return "".join(res[::-1])