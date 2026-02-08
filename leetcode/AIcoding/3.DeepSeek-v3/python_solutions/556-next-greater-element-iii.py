class Solution:
    def nextGreaterElement(self, n: int) -> int:
        digits = list(str(n))
        length = len(digits)
        pivot = length - 2

        while pivot >= 0 and digits[pivot] >= digits[pivot + 1]:
            pivot -= 1

        if pivot == -1:
            return -1

        swap = length - 1
        while digits[swap] <= digits[pivot]:
            swap -= 1

        digits[pivot], digits[swap] = digits[swap], digits[pivot]
        digits[pivot + 1:] = digits[pivot + 1:][::-1]

        res = int(''.join(digits))
        return res if res < 2**31 else -1