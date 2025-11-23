class Solution:
    def minimumString(self, a: str, b: str, c: str) -> str:
        def merge(s, t):
            if t in s:
                return s
            for i in range(len(s)):
                if s[i:] == t[:len(s)-i]:
                    return s + t[len(s)-i:]
            return s + t

        candidates = []
        from itertools import permutations
        for p in permutations([a, b, c]):
            merged = merge(merge(p[0], p[1]), p[2])
            candidates.append(merged)

        candidates = list(set(candidates))
        candidates.sort(key=lambda x: (len(x), x))
        return candidates[0]