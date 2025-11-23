class Solution:
    def checkDigitsEqualAfterOperationsII(self, s: str) -> bool:
        current_s = s

        while len(current_s) > 2:
            next_s_list = []
            i = 0
            while i < len(current_s):
                digit1 = int(current_s[i])

                if i + 1 < len(current_s):
                    digit2 = int(current_s[i+1])
                    sum_val = digit1 + digit2

                    if sum_val >= 10:
                        final_digit_for_pair = (sum_val // 10) + (sum_val % 10)
                    else:
                        final_digit_for_pair = sum_val

                    next_s_list.append(str(final_digit_for_pair))
                    i += 2
                else:
                    next_s_list.append(current_s[i])
                    i += 1

            current_s = "".join(next_s_list)

        if len(current_s) == 1:
            return True
        else:
            return current_s[0] == current_s[1]