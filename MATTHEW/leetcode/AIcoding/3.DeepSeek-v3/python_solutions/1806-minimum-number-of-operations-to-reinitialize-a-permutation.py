class Solution:
    def reinitializePermutation(self, n: int) -> int:
        perm = [i for i in range(n)]
        original = perm.copy()
        operations = 0

        while True:
            operations += 1
            arr = [0] * n
            for i in range(n):
                if i % 2 == 0:
                    arr[i] = perm[i // 2]
                else:
                    arr[i] = perm[n // 2 + (i - 1) // 2]
            perm = arr
            if perm == original:
                break

        return operations