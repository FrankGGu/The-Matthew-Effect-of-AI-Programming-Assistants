class Solution:
    def getDistances(self, arr: List[int]) -> List[int]:
        from collections import defaultdict

        index_map = defaultdict(list)
        for index, value in enumerate(arr):
            index_map[value].append(index)

        result = [0] * len(arr)

        for indices in index_map.values():
            total_sum = sum(indices)
            current_sum = 0
            count = len(indices)

            for i in range(count):
                result[indices[i]] = (i * indices[i] - current_sum) + (total_sum - current_sum - indices[i] * (count - i))
                current_sum += indices[i]

        return result