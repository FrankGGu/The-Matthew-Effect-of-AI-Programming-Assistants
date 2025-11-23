class Solution:
    def arrayRankTransform(self, matrix: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        flat = []
        for row in matrix:
            flat.extend(row)

        sorted_unique = sorted(set(flat))
        rank_map = {num: i+1 for i, num in enumerate(sorted_unique)}

        result = []
        for row in matrix:
            new_row = [rank_map[num] for num in row]
            result.append(new_row)

        return result