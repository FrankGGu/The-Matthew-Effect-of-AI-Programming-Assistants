class Solution:
    def findDiagonalOrder(self, mat: List[List[int]]) -> List[int]:
        if not mat or not mat[0]:
            return []

        m, n = len(mat), len(mat[0])
        result = []
        diagonal_dict = defaultdict(list)

        for i in range(m):
            for j in range(n):
                diagonal_dict[i + j].append(mat[i][j])

        for key in diagonal_dict:
            if key % 2 == 0:
                result.extend(diagonal_dict[key][::-1])
            else:
                result.extend(diagonal_dict[key])

        return result