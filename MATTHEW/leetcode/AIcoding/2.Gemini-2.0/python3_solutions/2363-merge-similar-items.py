class Solution:
    def mergeSimilarItems(self, items1: List[List[int]], items2: List[List[int]]) -> List[List[int]]:
        merged = {}
        for item in items1:
            if item[0] not in merged:
                merged[item[0]] = 0
            merged[item[0]] += item[1]

        for item in items2:
            if item[0] not in merged:
                merged[item[0]] = 0
            merged[item[0]] += item[1]

        result = []
        for value, weight in merged.items():
            result.append([value, weight])

        result.sort()
        return result