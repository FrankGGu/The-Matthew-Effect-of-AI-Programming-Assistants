class Solution:
    def minimizeXor(self, num1: int, num2: int) -> int:
        count = bin(num2).count('1')
        result = 0
        for i in range(31, -1, -1):
            if num1 & (1 << i):
                if count > 0:
                    result |= (1 << i)
                    count -= 1
        i = 0
        while count > 0:
            if not (result & (1 << i)):
                result |= (1 << i)
                count -= 1
            i += 1
        return result