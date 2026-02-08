class Solution:
    def areSimilar(self, A: List[List[int]], B: List[List[int]]) -> bool:
        def get_rows(A):
            return [tuple(A[i]) for i in range(len(A))]

        return sorted(get_rows(A)) == sorted(get_rows(B))