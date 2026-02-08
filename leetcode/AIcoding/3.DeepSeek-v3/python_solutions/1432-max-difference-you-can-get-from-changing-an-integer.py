class Solution:
    def maxDiff(self, num: int) -> int:
        s = str(num)
        max_num = num
        min_num = num

        # Find maximum number
        for c in s:
            if c != '9':
                max_num = int(s.replace(c, '9'))
                break

        # Find minimum number
        if s[0] != '1':
            min_num = int(s.replace(s[0], '1'))
        else:
            for c in s[1:]:
                if c != '0' and c != '1':
                    min_num = int(s.replace(c, '0'))
                    break

        return max_num - min_num