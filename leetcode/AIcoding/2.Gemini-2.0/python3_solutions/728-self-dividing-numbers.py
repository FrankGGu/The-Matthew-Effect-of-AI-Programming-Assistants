class Solution:
    def selfDividingNumbers(self, left: int, right: int) -> list[int]:
        result = []
        for num in range(left, right + 1):
            s = str(num)
            flag = True
            for digit in s:
                digit = int(digit)
                if digit == 0 or num % digit != 0:
                    flag = False
                    break
            if flag:
                result.append(num)
        return result