class Solution:
    def minInteger(self, num: str, k: int) -> str:
        n = len(num)
        pos = [[] for _ in range(10)]
        for i, digit in enumerate(num):
            pos[int(digit)].append(i)

        res = ""
        bit = [0] * (n + 1)

        def update(i, val):
            i += 1
            while i <= n:
                bit[i] += val
                i += i & -i

        def query(i):
            i += 1
            res = 0
            while i > 0:
                res += bit[i]
                i -= i & -i
            return res

        for _ in range(n):
            for digit in range(10):
                if pos[digit]:
                    idx = pos[digit][0]
                    swaps = idx - query(idx)
                    if swaps <= k:
                        k -= swaps
                        res += str(digit)
                        update(idx, 1)
                        pos[digit].pop(0)
                        break

        return res