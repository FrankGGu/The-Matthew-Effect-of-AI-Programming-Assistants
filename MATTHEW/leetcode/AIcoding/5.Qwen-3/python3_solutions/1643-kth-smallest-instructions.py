class Solution:
    def kthSmallestPath(self, r: int, c: int, k: int) -> str:
        from math import comb

        res = []
        while r > 0 and c > 0:
            count = comb(r + c - 2, r - 1)
            if k <= count:
                res.append('H')
                r -= 1
            else:
                res.append('V')
                c -= 1
                k -= count
        res.extend(['H'] * r)
        res.extend(['V'] * c)
        return ''.join(res)