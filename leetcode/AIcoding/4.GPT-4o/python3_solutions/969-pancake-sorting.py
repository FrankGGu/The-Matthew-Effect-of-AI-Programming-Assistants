class Solution:
    def pancakeSort(self, A: List[int]) -> List[int]:
        def flip(k):
            A[:k] = reversed(A[:k])

        res = []
        n = len(A)
        for size in range(n, 1, -1):
            max_idx = A.index(max(A[:size]))
            if max_idx + 1 != size:
                if max_idx != 0:
                    res.append(max_idx + 1)
                    flip(max_idx + 1)
                res.append(size)
                flip(size)
        return res