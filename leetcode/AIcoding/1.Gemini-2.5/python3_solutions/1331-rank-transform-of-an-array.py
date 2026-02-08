class Solution:
    def arrayRankTransform(self, arr: list[int]) -> list[int]:
        if not arr:
            return []

        sorted_unique_elements = sorted(list(set(arr)))

        rank_map = {}
        for i, num in enumerate(sorted_unique_elements):
            rank_map[num] = i + 1

        result = []
        for num in arr:
            result.append(rank_map[num])

        return result