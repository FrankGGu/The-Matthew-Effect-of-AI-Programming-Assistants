class Solution:
    def maxAreaRect(self, points: list[list[int]]) -> int:
        events = []
        for x1, y1, x2, y2 in points:
            events.append((x1, y1, y2, 1))
            events.append((x2, y1, y2, -1))

        events.sort()
        active = set()
        last_x = events[0][0]
        ans = 0

        def query(active):
            sorted_active = sorted(list(active))
            if len(sorted_active) < 2:
                return 0
            max_diff = 0
            for i in range(len(sorted_active) - 1):
                max_diff = max(max_diff, sorted_active[i+1][0] - sorted_active[i][1])
            return max_diff

        for x, y1, y2, type in events:
            width = x - last_x
            ans = max(ans, width * query(active))
            last_x = x

            if type == 1:
                active.add((y1, y2))
            else:
                active.remove((y1, y2))

        return ans