class Solution:
    def nearestPalindromic(self, n: str) -> str:
        l = len(n)
        candidates = [str(10 ** (l - 1) - 1), str(10 ** l + 1)]
        prefix = n[:(l + 1) // 2]
        for p in [str(int(prefix) - 1), prefix, str(int(prefix) + 1)]:
            candidates.append(p + (p[:-1] if l % 2 else p)[::-1])
        ans = ""
        num = int(n)
        diff = float('inf')
        for cand in candidates:
            if cand == n:
                continue
            cand_num = int(cand)
            cur_diff = abs(cand_num - num)
            if cur_diff < diff:
                diff = cur_diff
                ans = cand
            elif cur_diff == diff:
                ans = str(min(int(ans), cand_num))
        return ans