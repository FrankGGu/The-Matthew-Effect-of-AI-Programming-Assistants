class Solution:
    def minScore(self, n: int, roads: list[list[int]]) -> int:
        min_overall_distance = float('inf')
        for _, _, distance in roads:
            min_overall_distance = min(min_overall_distance, distance)
        return min_overall_distance