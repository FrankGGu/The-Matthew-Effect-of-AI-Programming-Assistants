class Solution:
    def rectangleArea(self, rectangles: List[List[int]]) -> int:
        events = []
        for x1, y1, x2, y2 in rectangles:
            events.append((x1, y1, y2, 1))
            events.append((x2, y1, y2, -1))

        events.sort()

        res = 0
        prev_x = None
        active = []

        for x, y1, y2, typ in events:
            if prev_x is not None and x > prev_x and active:
                total_height = 0
                for a, b in active:
                    total_height += b - a
                res += (x - prev_x) * total_height

            prev_x = x
            if typ == 1:
                active.append((y1, y2))
                active.sort()
            else:
                for i in range(len(active)):
                    if active[i] == (y1, y2):
                        del active[i]
                        break

        return res % (10**9 + 7)