class Solution:
    def minMaxDifference(self, num: str) -> int:
        min_num = num
        max_num = num
        for i in range(len(num)):
            if num[i] != '9':
                max_num = num.replace(num[i], '9')
                break
        for i in range(len(num)):
            if num[i] != '0':
                min_num = num.replace(num[i], '0')
                break
        return int(max_num) - int(min_num)