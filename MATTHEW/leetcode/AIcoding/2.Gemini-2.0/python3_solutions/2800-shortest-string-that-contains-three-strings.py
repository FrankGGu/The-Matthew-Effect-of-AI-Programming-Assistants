class Solution:
    def shortestCommonSuperstring(self, s1: str, s2: str, s3: str) -> str:
        def overlap(s1, s2):
            for i in range(min(len(s1), len(s2)), -1, -1):
                if s1.endswith(s2[:i]):
                    return s1 + s2[i:]
            return s1 + s2

        def solve(a, b, c):
            ab = overlap(a, b)
            abc = overlap(ab, c)
            ba = overlap(b, a)
            bac = overlap(ba, c)
            ac = overlap(a, c)
            acb = overlap(ac, b)
            ca = overlap(c, a)
            cab = overlap(ca, b)
            bc = overlap(b, c)
            bca = overlap(bc, a)
            cb = overlap(c, b)
            cba = overlap(cb, a)
            return min(abc, bac, acb, cab, bca, cba, key=len)

        return min(solve(s1, s2, s3), solve(s1, s3, s2), solve(s2, s1, s3),
                   solve(s2, s3, s1), solve(s3, s1, s2), solve(s3, s2, s1), key=len)