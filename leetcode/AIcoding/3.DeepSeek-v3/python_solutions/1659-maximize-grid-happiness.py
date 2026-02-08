class Solution:
    def getMaxGridHappiness(self, m: int, n: int, introvertsCount: int, extrovertsCount: int) -> int:
        from functools import lru_cache

        if m < n:
            m, n = n, m

        total = 3 ** n
        mask_info = []
        for mask in range(total):
            mask_info.append([])
            tmp = mask
            for _ in range(n):
                mask_info[-1].append(tmp % 3)
                tmp //= 3

        def calc(x, y):
            if x == 0 or y == 0:
                return 0
            if x == 1 and y == 1:
                return -60
            if x == 2 and y == 2:
                return 40
            return -10

        @lru_cache(maxsize=None)
        def dp(pos, prev_mask, intro, extro):
            if pos == m * n:
                return 0
            i, j = pos // n, pos % n
            res = 0
            for k in range(3):
                if k == 1 and intro == 0:
                    continue
                if k == 2 and extro == 0:
                    continue
                new_intro = intro - (1 if k == 1 else 0)
                new_extro = extro - (1 if k == 2 else 0)
                current = 0
                if k == 1:
                    current += 120
                elif k == 2:
                    current += 40
                left = mask_info[prev_mask][j - 1] if j > 0 else 0
                up = mask_info[prev_mask][j] if i > 0 else 0
                current += calc(k, left) + calc(k, up)
                new_mask = prev_mask - mask_info[prev_mask][j] * (3 ** j)
                new_mask += k * (3 ** j)
                res = max(res, current + dp(pos + 1, new_mask, new_intro, new_extro))
            return res

        return dp(0, 0, introvertsCount, extrovertsCount)