class Solution:
    def findMinDifference(self, timePoints: list[str]) -> int:

        minutes = []
        for time_str in timePoints:
            h_str, m_str = time_str.split(':')
            h = int(h_str)
            m = int(m_str)
            minutes.append(h * 60 + m)

        minutes.sort()

        min_diff = float('inf')

        for i in range(1, len(minutes)):
            diff = minutes[i] - minutes[i-1]
            min_diff = min(min_diff, diff)

        wrap_around_diff = (24 * 60 - minutes[-1]) + minutes[0]
        min_diff = min(min_diff, wrap_around_diff)

        return min_diff