class Solution:
    def intersectionSizeTwo(self, intervals: list[list[int]]) -> int:
        intervals.sort(key=lambda x: (x[1], -x[0]))

        ans = 0
        p1 = -1
        p2 = -1

        for a, b in intervals:
            # Case 1: Neither p1 nor p2 are in the current interval [a, b].
            # This means p2 (and therefore p1) is less than 'a'.
            if p2 < a:
                # We need to add two new points.
                # To maximize their utility for future intervals, we pick b-1 and b.
                ans += 2
                p1 = b - 1
                p2 = b
            # Case 2: Only p2 is in the current interval [a, b], but p1 is not.
            # This means p1 < a <= p2 <= b.
            elif p1 < a <= p2:
                # We need to add one more point.
                # To maximize its utility, we pick b.
                ans += 1
                p1 = p2  # The old p2 becomes the new p1
                p2 = b   # The new point b becomes the new p2
            # Case 3: Both p1 and p2 are in the current interval [a, b].
            # This means a <= p1 < p2 <= b.
            # The interval is already covered, so do nothing.

        return ans