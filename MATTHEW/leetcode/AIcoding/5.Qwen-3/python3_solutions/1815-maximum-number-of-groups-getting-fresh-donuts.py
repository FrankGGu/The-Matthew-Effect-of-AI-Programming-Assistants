class Solution:
    def maxGroups(self, batchSize: int, groups: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for g in groups:
            count[g % batchSize] += 1

        res = 0
        for i in range(1, batchSize):
            if count[i] == 0:
                continue
            j = (batchSize - i) % batchSize
            if i == j:
                res += count[i] // 2
            else:
                res += min(count[i], count[j])
                count[j] = 0
        return res