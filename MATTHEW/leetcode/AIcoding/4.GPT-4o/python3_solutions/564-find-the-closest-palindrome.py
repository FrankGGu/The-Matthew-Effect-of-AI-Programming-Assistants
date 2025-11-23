class Solution:
    def nearestPalindromic(self, n: str) -> str:
        candidates = set()
        length = len(n)
        prefix = int(n[:(length + 1) // 2])

        for p in [prefix - 1, prefix, prefix + 1]:
            candidates.add(str(10 ** length + 1))
            candidates.add(str(10 ** (length - 1) - 1))
            candidates.add(str(int(str(p) + str(p)[-1 - (length % 2):][::-1])))

        candidates.discard(n)
        closest = min(candidates, key=lambda x: (abs(int(x) - int(n)), int(x)))
        return closest