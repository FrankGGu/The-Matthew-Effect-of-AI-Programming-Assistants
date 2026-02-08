class Solution:
    def movesToStamp(self, stamp: str, target: str) -> list[int]:
        S, T = list(stamp), list(target)
        m, n = len(S), len(T)
        res = []
        visited = [False] * (n - m + 1)

        def can_replace(i):
            for j in range(m):
                if T[i + j] == '?':
                    continue
                if T[i + j] != S[j]:
                    return False
            return True

        def do_replace(i):
            stars = 0
            for j in range(m):
                if T[i + j] != '?':
                    T[i + j] = '?'
                    stars += 1
            return stars

        count = 0
        while count < n:
            replaced = False
            for i in range(n - m + 1):
                if not visited[i] and can_replace(i):
                    stars = do_replace(i)
                    count += stars
                    visited[i] = True
                    res.append(i)
                    replaced = True
            if not replaced:
                return []

        return res[::-1]