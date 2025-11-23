from collections import Counter

class Solution:
    def minAnagramLength(self, s: str) -> int:
        n = len(s)
        for k in range(1, n + 1):
            if n % k != 0:
                continue
            target = Counter(s[:k])
            valid = True
            for i in range(k, n, k):
                current = Counter(s[i:i+k])
                if current != target:
                    valid = False
                    break
            if valid:
                return k
        return n