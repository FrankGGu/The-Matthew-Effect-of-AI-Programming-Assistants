class Solution:
    def relativeRanks(self, score: List[int]) -> List[str]:
        n = len(score)
        idx = sorted(range(n), key=lambda i: score[i], reverse=True)
        res = [0] * n
        ranks = ["Gold Medal", "Silver Medal", "Bronze Medal"]
        for i in range(n):
            if i < 3:
                res[idx[i]] = ranks[i]
            else:
                res[idx[i]] = str(i + 1)
        return res