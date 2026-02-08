class Solution:
    def arrayRankTransform(self, arr: List[int]) -> List[int]:
        sorted_arr = sorted(list(set(arr)))
        rank_map = {num: rank for rank, num in enumerate(sorted_arr, 1)}
        return [rank_map[num] for num in arr]