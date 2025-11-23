class Solution:
    def arrayRankTransform(self, arr: List[int]) -> List[int]:
        sorted_arr = sorted(set(arr))
        rank_dict = {v: i+1 for i, v in enumerate(sorted_arr)}
        return [rank_dict[num] for num in arr]