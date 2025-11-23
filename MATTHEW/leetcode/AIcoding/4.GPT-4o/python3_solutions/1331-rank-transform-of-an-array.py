class Solution:
    def arrayRankTransform(self, arr: List[int]) -> List[int]:
        sorted_unique = sorted(set(arr))
        rank = {value: idx + 1 for idx, value in enumerate(sorted_unique)}
        return [rank[x] for x in arr]