class Solution:
    def oddEvenJumps(self, A: List[int]) -> int:
        n = len(A)
        if n == 1:
            return 1

        odd_jump = [False] * n
        even_jump = [False] * n
        odd_jump[-1] = even_jump[-1] = True

        sorted_indices = sorted(range(n), key=lambda i: A[i])
        next_higher = [None] * n
        for i in range(n):
            idx = sorted_indices[i]
            if i > 0:
                next_higher[idx] = sorted_indices[i - 1]
            if i < n - 1:
                next_higher[sorted_indices[i + 1]] = sorted_indices[i + 1]

        for i in range(n - 2, -1, -1):
            if next_higher[i] is not None:
                odd_jump[i] = even_jump[next_higher[i]]

        sorted_indices = sorted(range(n), key=lambda i: -A[i])
        next_lower = [None] * n
        for i in range(n):
            idx = sorted_indices[i]
            if i > 0:
                next_lower[idx] = sorted_indices[i - 1]
            if i < n - 1:
                next_lower[sorted_indices[i + 1]] = sorted_indices[i + 1]

        for i in range(n - 2, -1, -1):
            if next_lower[i] is not None:
                even_jump[i] = odd_jump[next_lower[i]]

        return sum(odd_jump)