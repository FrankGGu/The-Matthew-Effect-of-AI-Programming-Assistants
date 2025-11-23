class Solution:
    def maxDiff(self, num: int) -> int:
        s = str(num)

        max_s_list = list(s)
        x_for_max = ''
        for char in max_s_list:
            if char != '9':
                x_for_max = char
                break

        if x_for_max:
            for i in range(len(max_s_list)):
                if max_s_list[i] == x_for_max:
                    max_s_list[i] = '9'
        max_val = int("".join(max_s_list))

        min_s_list = list(s)

        if min_s_list[0] != '1':
            x_for_min = min_s_list[0]
            for i in range(len(min_s_list)):
                if min_s_list[i] == x_for_min:
                    min_s_list[i] = '1'
        else:
            y_for_min = ''
            for i in range(1, len(min_s_list)):
                if min_s_list[i] != '0' and min_s_list[i] != '1':
                    y_for_min = min_s_list[i]
                    break

            if y_for_min:
                for i in range(len(min_s_list)):
                    if min_s_list[i] == y_for_min:
                        min_s_list[i] = '0'

        min_val = int("".join(min_s_list))

        return max_val - min_val