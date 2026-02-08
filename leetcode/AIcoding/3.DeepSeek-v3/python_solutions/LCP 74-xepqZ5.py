class Solution:
    def fieldOfGreatestBlessing(self, forceField: List[List[int]]) -> int:
        events = []
        for x, y, side in forceField:
            x1 = x - side / 2
            x2 = x + side / 2
            y1 = y - side / 2
            y2 = y + side / 2
            events.append((x1, y1, y2, 1))
            events.append((x2, y1, y2, -1))

        events.sort()

        active_intervals = []
        max_count = 0
        current_count = 0

        for x, y1, y2, typ in events:
            if typ == 1:
                active_intervals.append((y1, y2))
                active_intervals.sort()
                current_count = self.calculate_overlap(active_intervals)
            else:
                active_intervals.remove((y1, y2))
                current_count = self.calculate_overlap(active_intervals)
            if current_count > max_count:
                max_count = current_count
        return max_count

    def calculate_overlap(self, intervals):
        if not intervals:
            return 0
        intervals.sort()
        merged = [intervals[0]]
        for current in intervals[1:]:
            last = merged[-1]
            if current[0] <= last[1]:
                new_start = last[0]
                new_end = max(last[1], current[1])
                merged[-1] = (new_start, new_end)
            else:
                merged.append(current)
        total = 0
        for start, end in merged:
            total += end - start
        return total