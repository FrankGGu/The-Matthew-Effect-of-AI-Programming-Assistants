class Solution:
    def nearestPalindromic(self, n: str) -> str:
        length = len(n)
        candidates = set()
        candidates.add(str(10 ** (length - 1) - 1))
        candidates.add(str(10 ** length + 1))
        prefix = int(n[:(length + 1) // 2])
        for num in [prefix - 1, prefix, prefix + 1]:
            s = str(num)
            if length % 2 == 0:
                candidate = s + s[::-1]
            else:
                candidate = s + s[:-1][::-1]
            candidates.add(candidate)
        candidates.discard(n)
        min_diff = float('inf')
        res = None
        for candidate in candidates:
            diff = abs(int(candidate) - int(n))
            if diff < min_diff or (diff == min_diff and int(candidate) < int(res)):
                min_diff = diff
                res = candidate
        return res