import heapq

class Solution:
    def kthSmallest(self, mat: list[list[int]], k: int) -> int:
        m, n = len(mat), len(mat[0])
        pq = [mat[0][0]]
        visited = set()
        visited.add((0,))

        for _ in range(min(k, m * n)):
            curr_sum = heapq.heappop(pq)

            indices = []
            for i in range(len(mat)):
                found = False
                for j in range(len(mat[i])):
                    if curr_sum - mat[i][0] + mat[i][j] in pq:
                        pass

            curr_indices = [0] * m

            temp_sum = curr_sum