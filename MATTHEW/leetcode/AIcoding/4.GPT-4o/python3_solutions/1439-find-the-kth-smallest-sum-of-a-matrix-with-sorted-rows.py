import heapq

class Solution:
    def kthSmallest(self, mat: List[List[int]], k: int) -> int:
        m, n = len(mat), len(mat[0])
        min_heap = [(sum(row[0] for row in mat), [0] * m)]
        seen = {(0,)}

        for _ in range(k):
            total, indices = heapq.heappop(min_heap)
            for i in range(m):
                if indices[i] + 1 < n:
                    new_indices = list(indices)
                    new_indices[i] += 1
                    new_indices_tuple = tuple(new_indices)
                    if new_indices_tuple not in seen:
                        seen.add(new_indices_tuple)
                        new_total = total - mat[i][indices[i]] + mat[i][new_indices[i]]
                        heapq.heappush(min_heap, (new_total, new_indices_tuple))

        return total