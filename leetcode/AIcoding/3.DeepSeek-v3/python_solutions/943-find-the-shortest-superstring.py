class Solution:
    def shortestSuperstring(self, words: List[str]) -> str:
        n = len(words)
        overlaps = [[0] * n for _ in range(n)]

        for i in range(n):
            for j in range(n):
                if i != j:
                    a, b = words[i], words[j]
                    max_len = min(len(a), len(b))
                    for k in range(max_len, -1, -1):
                        if a.endswith(b[:k]):
                            overlaps[i][j] = k
                            break

        dp = [[0] * n for _ in range(1 << n)]
        parent = [[-1] * n for _ in range(1 << n)]

        for mask in range(1 << n):
            for bit in range(n):
                if not (mask & (1 << bit)):
                    continue
                prev_mask = mask ^ (1 << bit)
                if prev_mask == 0:
                    continue
                for i in range(n):
                    if prev_mask & (1 << i):
                        val = dp[prev_mask][i] + overlaps[i][bit]
                        if val > dp[mask][bit]:
                            dp[mask][bit] = val
                            parent[mask][bit] = i

        mask = (1 << n) - 1
        bit = max(range(n), key=lambda x: dp[mask][x])
        res = []
        seen = [False] * n

        while bit != -1:
            seen[bit] = True
            prev_bit = parent[mask][bit]
            if prev_bit == -1:
                res.append(words[bit])
            else:
                overlap = overlaps[prev_bit][bit]
                res.append(words[bit][overlap:])
            mask ^= (1 << bit)
            bit = prev_bit

        for i in range(n):
            if not seen[i]:
                res.append(words[i])

        return ''.join(reversed(res))