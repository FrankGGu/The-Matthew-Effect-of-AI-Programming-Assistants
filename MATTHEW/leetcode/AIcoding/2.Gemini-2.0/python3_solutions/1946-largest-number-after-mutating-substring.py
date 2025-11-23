class Solution:
    def maximumSubarray(self, num: str, change: list[int]) -> str:
        n = len(num)
        res = list(num)
        start = -1
        for i in range(n):
            digit = int(num[i])
            if change[digit] > digit:
                start = i
                break
        if start == -1:
            return num
        end = start
        for i in range(start, n):
            digit = int(num[i])
            if change[digit] >= digit:
                res[i] = str(change[digit])
                end = i
            else:
                break
        return "".join(res)