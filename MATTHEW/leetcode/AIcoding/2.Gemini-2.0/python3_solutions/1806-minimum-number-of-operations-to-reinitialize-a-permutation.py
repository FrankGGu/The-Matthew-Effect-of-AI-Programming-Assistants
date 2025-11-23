class Solution:
    def reinitializePermutation(self, n: int) -> int:
        perm = list(range(n))
        arr = list(range(n))
        count = 0
        while True:
            new_arr = [0] * n
            for i in range(n):
                if i % 2 == 0:
                    new_arr[i] = arr[i // 2]
                else:
                    new_arr[i] = arr[n // 2 + (i - 1) // 2]
            count += 1
            if new_arr == perm:
                return count
            arr = new_arr[:]