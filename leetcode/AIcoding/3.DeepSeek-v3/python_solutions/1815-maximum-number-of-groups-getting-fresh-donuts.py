from functools import lru_cache

class Solution:
    def maxHappyGroups(self, batchSize: int, groups: List[int]) -> int:
        n = len(groups)
        groups = [g % batchSize for g in groups]
        count = [0] * batchSize
        for g in groups:
            count[g] += 1

        res = count[0]
        count[0] = 0

        for i in range(1, batchSize):
            pair = batchSize - i
            if pair < i:
                continue
            if pair == i:
                res += count[i] // 2
                count[i] %= 2
            else:
                min_p = min(count[i], count[pair])
                res += min_p
                count[i] -= min_p
                count[pair] -= min_p

        @lru_cache(maxsize=None)
        def dfs(remain, cnt):
            if sum(cnt) == 0:
                return 0
            res = 0
            for i in range(batchSize):
                if cnt[i] == 0:
                    continue
                new_cnt = list(cnt)
                new_cnt[i] -= 1
                new_remain = (remain - i) % batchSize
                current = 1 if new_remain == 0 else 0
                res = max(res, current + dfs(new_remain, tuple(new_cnt)))
            return res

        return res + dfs(0, tuple(count))