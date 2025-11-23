class Solution:
    def splitPainting(self, segments: List[List[int]]) -> List[List[int]]:
        events = []
        for start, end, color in segments:
            events.append((start, 'start', color))
            events.append((end, 'end', color))

        events.sort()

        res = []
        prev_time = None
        current_color = 0
        for time, typ, color in events:
            if prev_time is not None and time != prev_time and current_color != 0:
                res.append([prev_time, time, current_color])
            if typ == 'start':
                current_color += color
            else:
                current_color -= color
            prev_time = time

        return res