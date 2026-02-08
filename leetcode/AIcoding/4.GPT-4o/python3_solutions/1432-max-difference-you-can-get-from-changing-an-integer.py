class Solution:
    def maximumDifference(self, num: int) -> int:
        str_num = str(num)
        max_num = str_num
        min_num = str_num

        for i in range(len(str_num)):
            if str_num[i] != '9':
                max_num = max_num[:i] + '9' + max_num[i+1:]
                break

        for i in range(len(str_num)):
            if str_num[i] != '0':
                min_num = min_num[:i] + '0' + min_num[i+1:]
                break

        return int(max_num) - int(min_num)