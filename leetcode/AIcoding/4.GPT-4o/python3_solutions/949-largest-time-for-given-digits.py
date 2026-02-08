from itertools import permutations

class Solution:
    def largestTimeFromDigits(self, A: List[int]) -> str:
        max_time = -1
        for perm in permutations(A):
            h, m = perm[0] * 10 + perm[1], perm[2] * 10 + perm[3]
            if 0 <= h < 24 and 0 <= m < 60:
                max_time = max(max_time, h * 60 + m)
        if max_time == -1:
            return ""
        return f"{max_time // 60:02}:{max_time % 60:02}"