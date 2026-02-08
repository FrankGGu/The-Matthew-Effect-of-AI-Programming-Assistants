class Solution:
    def rectangleArea(self, rectangles: list[list[int]]) -> int:
        events = []
        for x1, y1, x2, y2 in rectangles:
            events.append((x1, 0, y1, y2))
            events.append((x2, 1, y1, y2))
        events.sort()

        active = []
        area = 0
        prev_x = 0
        MOD = 10**9 + 7

        def update_active(active):
            active.sort()
            merged = []
            if active:
                start, end = active[0]
                for i in range(1, len(active)):
                    if active[i][0] <= end:
                        end = max(end, active[i][1])
                    else:
                        merged.append((start, end))
                        start, end = active[i]
                merged.append((start, end))
            return merged

        for x, type, y1, y2 in events:
            if active:
                length = 0
                for start, end in active:
                    length += end - start
                area = (area + (x - prev_x) * length) % MOD

            if type == 0:
                active.append((y1, y2))
            else:
                active.remove((y1, y2))

            active = update_active(active)
            prev_x = x

        return area