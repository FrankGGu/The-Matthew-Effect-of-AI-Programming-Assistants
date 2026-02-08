import bisect

class Solution:
    def countRectangles(self, rectangles: List[List[int]], points: List[List[int]]) -> List[int]:
        # Group rectangles by their y-coordinate
        y_to_xs = defaultdict(list)
        for l, h in rectangles:
            y_to_xs[h].append(l)

        # Sort the x-coordinates for each y-coordinate
        for y in y_to_xs:
            y_to_xs[y].sort()

        # Get sorted list of unique y-coordinates
        ys = sorted(y_to_xs.keys())

        res = []
        for x, y in points:
            # Find all y-coordinates >= current point's y
            idx = bisect.bisect_left(ys, y)
            count = 0
            for h in ys[idx:]:
                xs = y_to_xs[h]
                # Find all x-coordinates >= current point's x
                cnt = len(xs) - bisect.bisect_left(xs, x)
                count += cnt
            res.append(count)
        return res