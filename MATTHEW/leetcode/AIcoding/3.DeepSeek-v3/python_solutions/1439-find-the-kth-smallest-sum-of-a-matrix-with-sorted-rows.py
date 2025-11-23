import heapq

class Solution:
    def kthSmallest(self, mat: List[List[int]], k: int) -> int:
        m, n = len(mat), len(mat[0])
        heap = []
        visited = set()
        initial_sum = sum(row[0] for row in mat)
        initial_indices = tuple([0] * m)
        heapq.heappush(heap, (initial_sum, initial_indices))
        visited.add(initial_indices)

        for _ in range(k):
            current_sum, indices = heapq.heappop(heap)
            indices = list(indices)
            for i in range(m):
                if indices[i] + 1 < n:
                    new_indices = indices.copy()
                    new_indices[i] += 1
                    new_indices_tuple = tuple(new_indices)
                    if new_indices_tuple not in visited:
                        new_sum = current_sum - mat[i][indices[i]] + mat[i][new_indices[i]]
                        heapq.heappush(heap, (new_sum, new_indices_tuple))
                        visited.add(new_indices_tuple)
        return current_sum