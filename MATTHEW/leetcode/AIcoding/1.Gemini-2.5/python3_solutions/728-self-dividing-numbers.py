class Solution:
    def selfDividingNumbers(self, left: int, right: int) -> list[int]:
        result = []
        for num in range(left, right + 1):
            is_self_dividing = True
            s_num = str(num)
            for char_digit in s_num:
                digit = int(char_digit)
                if digit == 0 or num % digit != 0:
                    is_self_dividing = False
                    break
            if is_self_dividing:
                result.append(num)
        return result