class Solution:
    def interchangeableRectangles(self, rectangles: List[List[int]]) -> int:
        from collections import defaultdict

        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        ratio_count = defaultdict(int)
        result = 0

        for w, h in rectangles:
            g = gcd(w, h)
            key = (w // g, h // g)
            result += ratio_count[key]
            ratio_count[key] += 1

        return result