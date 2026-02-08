class Solution:
    def areSimilar(self, mat: List[List[int]], k: int) -> bool:
        m = len(mat)
        n = len(mat[0]) if m > 0 else 0

        for i in range(m):
            row = mat[i]
            shift = k % len(row) if len(row) != 0 else 0
            shifted_row = row[-shift:] + row[:-shift] if i % 2 == 0 else row[shift:] + row[:shift]
            if shifted_row != row:
                return False
        return True