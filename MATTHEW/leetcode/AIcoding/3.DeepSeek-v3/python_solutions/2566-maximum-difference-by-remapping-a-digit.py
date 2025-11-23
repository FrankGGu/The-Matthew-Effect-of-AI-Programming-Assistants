class Solution:
    def minMaxDifference(self, num: int) -> int:
        s = str(num)
        max_val = num
        min_val = num

        for d in s:
            new_max = int(s.replace(d, '9'))
            if new_max > max_val:
                max_val = new_max
            new_min = int(s.replace(d, '0'))
            if new_min < min_val:
                min_val = new_min

        return max_val - min_val