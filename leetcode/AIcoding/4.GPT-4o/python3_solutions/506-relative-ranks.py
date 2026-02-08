class Solution:
    def findRelativeRanks(self, score: List[int]) -> List[str]:
        sorted_scores = sorted(score, reverse=True)
        rank_map = {v: str(i + 1) for i, v in enumerate(sorted_scores)}

        for i in range(len(sorted_scores)):
            if rank_map[sorted_scores[i]] == '1':
                rank_map[sorted_scores[i]] = 'Gold Medal'
            elif rank_map[sorted_scores[i]] == '2':
                rank_map[sorted_scores[i]] = 'Silver Medal'
            elif rank_map[sorted_scores[i]] == '3':
                rank_map[sorted_scores[i]] = 'Bronze Medal'

        return [rank_map[s] for s in score]