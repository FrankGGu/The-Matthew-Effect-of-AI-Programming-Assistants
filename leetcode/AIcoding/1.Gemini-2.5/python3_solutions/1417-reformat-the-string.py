class Solution:
    def reformat(self, s: str) -> str:
        digits = []
        letters = []
        for char in s:
            if char.isdigit():
                digits.append(char)
            else:
                letters.append(char)

        len_d = len(digits)
        len_l = len(letters)

        if abs(len_d - len_l) > 1:
            return ""

        result = []

        if len_l > len_d:
            first_list = letters
            second_list = digits
        elif len_d > len_l:
            first_list = digits
            second_list = letters
        else: 
            first_list = letters
            second_list = digits

        for i in range(min(len_d, len_l)):
            result.append(first_list[i])
            result.append(second_list[i])

        if len(first_list) > len(second_list):
            result.append(first_list[-1])

        return "".join(result)