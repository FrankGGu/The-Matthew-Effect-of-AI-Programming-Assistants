class Solution:
    def minOperations(self, num: int) -> int:
        operations = 0
        while num > 0:
            if num % 2 == 1:
                num -= 1
                operations += 1
            else:
                num //= 2
                operations += 1
        return operations