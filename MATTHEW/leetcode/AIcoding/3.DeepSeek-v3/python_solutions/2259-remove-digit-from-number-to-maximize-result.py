class Solution:
    def removeDigit(self, number: str, digit: str) -> str:
        max_num = ""
        for i in range(len(number)):
            if number[i] == digit:
                current = number[:i] + number[i+1:]
                if current > max_num:
                    max_num = current
        return max_num