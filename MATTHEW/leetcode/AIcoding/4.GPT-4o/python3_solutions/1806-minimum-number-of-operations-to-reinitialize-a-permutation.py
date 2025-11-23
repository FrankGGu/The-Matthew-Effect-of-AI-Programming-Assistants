class Solution:
    def reinitializePermutation(self, n: int) -> int:
        original = list(range(n))
        perm = list(range(n))
        operations = 0

        while True:
            perm = [perm[perm[i]] for i in range(n)]
            operations += 1
            if perm == original:
                break

        return operations