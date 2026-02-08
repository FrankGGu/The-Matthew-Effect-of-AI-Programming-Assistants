from typing import List

class Solution:
    def mergeSimilarItems(self, items1: List[List[int]], items2: List[List[int]]) -> List[List[int]]:
        weights_map = {}

        for value, weight in items1:
            weights_map[value] = weights_map.get(value, 0) + weight

        for value, weight in items2:
            weights_map[value] = weights_map.get(value, 0) + weight

        result = []
        for value, total_weight in weights_map.items():
            result.append([value, total_weight])

        result.sort()

        return result