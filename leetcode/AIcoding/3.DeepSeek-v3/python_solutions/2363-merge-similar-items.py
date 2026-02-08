class Solution:
    def mergeSimilarItems(self, items1: List[List[int]], items2: List[List[int]]) -> List[List[int]]:
        weight_map = {}

        for value, weight in items1:
            if value in weight_map:
                weight_map[value] += weight
            else:
                weight_map[value] = weight

        for value, weight in items2:
            if value in weight_map:
                weight_map[value] += weight
            else:
                weight_map[value] = weight

        merged_items = sorted([[value, weight] for value, weight in weight_map.items()])
        return merged_items