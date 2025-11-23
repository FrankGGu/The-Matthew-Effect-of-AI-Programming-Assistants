import heapq

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
            if i < pair:
                min_pairs = min(count[i], count[pair])
                res += min_pairs
                count[i] -= min_pairs
                count[pair] -= min_pairs
            elif i == pair:
                res += count[i] // 2
                count[i] %= 2

        memo = {}

        def dfs(remain, cnt):
            key = tuple(cnt)
            if key in memo:
                return memo[key]
            max_happy = 0
            for i in range(1, batchSize):
                if cnt[i] == 0:
                    continue
                new_cnt = list(cnt)
                new_cnt[i] -= 1
                new_remain = (remain - i) % batchSize
                happy = dfs(new_remain, new_cnt) + (1 if remain == 0 else 0)
                if happy > max_happy:
                    max_happy = happy
            memo[key] = max_happy
            return max_happy

        res += dfs(0, count)
        return res