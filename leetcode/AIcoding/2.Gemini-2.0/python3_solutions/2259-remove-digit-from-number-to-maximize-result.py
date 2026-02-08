class Solution:
    def removeDigit(self, number: str, digit: str) -> str:
        indices = []
        for i, c in enumerate(number):
            if c == digit:
                indices.append(i)

        max_num = ""
        for i in indices:
            temp_num = number[:i] + number[i+1:]
            if max_num == "" or temp_num > max_num:
                max_num = temp_num

        return max_num