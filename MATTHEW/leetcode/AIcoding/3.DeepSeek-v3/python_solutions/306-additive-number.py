class Solution:
    def isAdditiveNumber(self, num: str) -> bool:
        n = len(num)
        for i in range(1, n):
            for j in range(i+1, n):
                num1 = num[:i]
                num2 = num[i:j]
                if (len(num1) > 1 and num1[0] == '0') or (len(num2) > 1 and num2[0] == '0'):
                    continue
                sum_str = str(int(num1) + int(num2))
                next_num = num1 + num2 + sum_str
                while len(next_num) < len(num):
                    num1, num2 = num2, sum_str
                    sum_str = str(int(num1) + int(num2))
                    next_num += sum_str
                if next_num == num:
                    return True
        return False