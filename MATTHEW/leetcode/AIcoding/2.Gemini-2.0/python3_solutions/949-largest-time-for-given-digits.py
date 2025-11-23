import itertools

class Solution:
    def largestTimeFromDigits(self, arr: List[int]) -> str:
        ans = ""
        for p in itertools.permutations(arr):
            h = p[0] * 10 + p[1]
            m = p[2] * 10 + p[3]
            if h < 24 and m < 60:
                time = "{:02d}:{:02d}".format(h, m)
                if time > ans:
                    ans = time
        return ans