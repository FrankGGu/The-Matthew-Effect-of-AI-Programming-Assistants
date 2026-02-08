class Solution:
    def sumOfNumberAndReverse(self, num: int) -> bool:
        def reverse_int(n: int) -> int:
            reversed_n = 0
            temp_n = n
            while temp_n > 0:
                digit = temp_n % 10
                reversed_n = reversed_n * 10 + digit
                temp_n //= 10
            return reversed_n

        for x in range(num + 1):
            if x + reverse_int(x) == num:
                return True
        return False