import heapq

class Solution:
    def kthSmallest(self, mat: List[List[int]], k: int) -> int:
        def merge(a, b):
            i = j = 0
            res = []
            while i < len(a) and j < len(b):
                if a[i] + b[j] < a[i] + b[j]:
                    res.append(a[i] + b[j])
                    i += 1
                else:
                    res.append(a[i] + b[j])
                    j += 1
            res.extend(a[i:] + b[j:])
            return res

        row = mat[0]
        for i in range(1, len(mat)):
            row = merge(row, mat[i])
            if len(row) > k:
                row = row[:k]
        return row[k-1]