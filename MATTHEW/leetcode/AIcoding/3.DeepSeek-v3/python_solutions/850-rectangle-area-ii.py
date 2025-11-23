class Solution:
    def rectangleArea(self, rectangles: List[List[int]]) -> int:
        events = []
        for x1, y1, x2, y2 in rectangles:
            events.append((y1, 1, x1, x2))
            events.append((y2, -1, x1, x2))
        events.sort()

        active = []
        res = 0
        prev_y = events[0][0]

        for y, typ, x1, x2 in events:
            res += self.calculate_area(active, prev_y, y)
            if typ == 1:
                active.append((x1, x2))
                active.sort()
            else:
                active.remove((x1, x2))
            prev_y = y

        return res % (10**9 + 7)

    def calculate_area(self, active, y1, y2):
        if not active:
            return 0
        total = 0
        prev_x1, prev_x2 = active[0]
        for x1, x2 in active[1:]:
            if x1 <= prev_x2:
                prev_x2 = max(prev_x2, x2)
            else:
                total += prev_x2 - prev_x1
                prev_x1, prev_x2 = x1, x2
        total += prev_x2 - prev_x1
        return total * (y2 - y1)