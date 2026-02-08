class Solution:
    def findRelativeRanks(self, score: List[int]) -> List[str]:
        sorted_scores = sorted([(s, i) for i, s in enumerate(score)], reverse=True)
        res = [""] * len(score)
        for rank, (s, i) in enumerate(sorted_scores, 1):
            if rank == 1:
                res[i] = "Gold Medal"
            elif rank == 2:
                res[i] = "Silver Medal"
            elif rank == 3:
                res[i] = "Bronze Medal"
            else:
                res[i] = str(rank)
        return res