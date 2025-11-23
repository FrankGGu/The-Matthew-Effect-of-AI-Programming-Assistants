class Solution:
    def minimumOperations(self, num: int) -> int:
        operations = 0
        num_str = str(num)
        for digit in num_str:
            if digit != '0':
                operations += 1
        return operations