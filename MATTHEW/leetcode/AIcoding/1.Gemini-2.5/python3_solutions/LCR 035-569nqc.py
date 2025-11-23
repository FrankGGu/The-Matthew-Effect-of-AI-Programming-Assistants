class Solution:
    def findMinDifference(self, timePoints: list[str]) -> int:
        minutes_list = []
        for time_str in timePoints:
            hh_str, mm_str = time_str.split(':')
            hh = int(hh_str)
            mm = int(mm_str)
            minutes_list.append(hh * 60 + mm)

        minutes_list.sort()

        min_diff = float('inf')

        for i in range(1, len(minutes_list)):
            diff = minutes_list[i] - minutes_list[i-1]
            min_diff = min(min_diff, diff)

        wrap_around_diff = (24 * 60 - minutes_list[-1]) + minutes_list[0]
        min_diff = min(min_diff, wrap_around_diff)

        return min_diff