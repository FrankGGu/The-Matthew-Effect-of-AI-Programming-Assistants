class Solution:
    def findShortestSuperstring(self, A: List[str]) -> str:
        from itertools import permutations

        def overlap(a, b):
            max_overlap = 0
            for i in range(1, min(len(a), len(b)) + 1):
                if a[-i:] == b[:i]:
                    max_overlap = i
            return max_overlap

        def merge(a, b):
            return a + b[overlap(a, b):]

        n = len(A)
        max_len = 0
        best_superstring = ""

        for perm in permutations(A):
            current_superstring = perm[0]
            for i in range(1, n):
                current_superstring = merge(current_superstring, perm[i])
            if len(current_superstring) > max_len:
                max_len = len(current_superstring)
                best_superstring = current_superstring

        return best_superstring