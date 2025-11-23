class Solution:
    def maxFreeTime(self, schedule: List[List[List[int]]]) -> int:
        intervals = []
        for person in schedule:
            for interval in person:
                intervals.append(interval)

        intervals.sort()
        merged = []
        for interval in intervals:
            if not merged:
                merged.append(interval)
            else:
                last = merged[-1]
                if interval[0] <= last[1]:
                    merged[-1] = [last[0], max(last[1], interval[1])]
                else:
                    merged.append(interval)

        max_gap = 0
        for i in range(1, len(merged)):
            gap = merged[i][0] - merged[i-1][1]
            if gap > max_gap:
                max_gap = gap

        return max_gap