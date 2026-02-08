class Solution:
    def largestTimeFromDigits(self, arr: List[int]) -> str:
        max_time = -1
        for h1, h2, m1, m2 in itertools.permutations(arr):
            hours = 10 * h1 + h2
            minutes = 10 * m1 + m2
            if hours < 24 and minutes < 60:
                max_time = max(max_time, hours * 60 + minutes)
        if max_time == -1:
            return ""
        else:
            return f"{max_time // 60:02d}:{max_time % 60:02d}"