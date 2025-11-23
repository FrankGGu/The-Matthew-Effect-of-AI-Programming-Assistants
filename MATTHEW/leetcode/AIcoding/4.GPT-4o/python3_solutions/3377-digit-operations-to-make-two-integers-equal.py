class Solution:
    def minOperations(self, num1: int, num2: int) -> int:
        if num1 == num2:
            return 0

        digits1 = set(str(num1))
        digits2 = set(str(num2))

        common_digits = digits1.intersection(digits2)
        unique_digits1 = digits1 - common_digits
        unique_digits2 = digits2 - common_digits

        return len(unique_digits1) + len(unique_digits2)