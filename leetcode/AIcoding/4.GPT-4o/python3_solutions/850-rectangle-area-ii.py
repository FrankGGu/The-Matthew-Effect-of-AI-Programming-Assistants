class Solution:
    def rectangleArea(self, rectangles: List[List[int]]) -> int:
        MOD = 10**9 + 7
        events = []
        for x1, y1, x2, y2 in rectangles:
            events.append((x1, y1, y2, 1))
            events.append((x2, y1, y2, -1))

        events.sort()

        def calculate_height(active_intervals):
            height = 0
            prev_y = -1
            count = 0
            for y, delta in active_intervals:
                if count > 0 and prev_y != -1:
                    height += y - prev_y
                count += delta
                prev_y = y
            return height

        active_intervals = []
        result = 0
        last_x = 0

        for x, y1, y2, typ in events:
            result += (x - last_x) * calculate_height(active_intervals) % MOD
            last_x = x

            if typ == 1:
                active_intervals.append((y1, 1))
                active_intervals.append((y2, -1))
            else:
                active_intervals.remove((y1, 1))
                active_intervals.remove((y2, -1))

            active_intervals.sort()

        return result % MOD