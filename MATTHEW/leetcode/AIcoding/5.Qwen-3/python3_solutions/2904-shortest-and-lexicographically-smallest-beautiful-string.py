class Solution:
    def shortestBeautifulString(self, s: str) -> str:
        from itertools import permutations

        def is_beautiful(t):
            for i in range(len(t) - 1):
                if t[i] == t[i + 1]:
                    return False
            return True

        n = len(s)
        min_len = float('inf')
        result = ""

        for length in range(1, n + 1):
            for perm in permutations(s, length):
                t = ''.join(perm)
                if is_beautiful(t):
                    if len(t) < min_len or (len(t) == min_len and t < result):
                        min_len = len(t)
                        result = t

        return result