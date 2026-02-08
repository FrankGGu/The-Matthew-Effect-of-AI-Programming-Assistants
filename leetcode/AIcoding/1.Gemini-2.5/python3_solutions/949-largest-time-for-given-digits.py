import itertools

class Solution:
    def largestTimeFromDigits(self, A: list[int]) -> str:
        max_time_minutes = -1

        for p in itertools.permutations(A):
            h1, h2, m1, m2 = p

            hours = h1 * 10 + h2
            minutes = m1 * 10 + m2

            if 0 <= hours <= 23 and 0 <= minutes <= 59:
                current_time_minutes = hours * 60 + minutes
                if current_time_minutes > max_time_minutes:
                    max_time_minutes = current_time_minutes

        if max_time_minutes == -1:
            return ""
        else:
            max_hours = max_time_minutes // 60
            max_minutes = max_time_minutes % 60
            return f"{max_hours:02d}:{max_minutes:02d}"