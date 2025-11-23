class Solution:
    def kMirror(self, k: int, n: int) -> int:
        def is_kmirror(num, k):
            s = str(num)
            if s != s[::-1]:
                return False
            ks = []
            while num > 0:
                ks.append(str(num % k))
                num = num // k
            ks = ''.join(ks)
            return ks == ks[::-1]

        res = []
        num = 1
        while len(res) < n:
            if is_kmirror(num, k):
                res.append(num)
            num += 1
        return sum(res)