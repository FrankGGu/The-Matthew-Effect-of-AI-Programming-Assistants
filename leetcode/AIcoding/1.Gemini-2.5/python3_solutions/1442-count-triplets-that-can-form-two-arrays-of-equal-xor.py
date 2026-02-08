class Solution:
    def countTriplets(self, arr: list[int]) -> int:
        n = len(arr)

        pxor = [0] * (n + 1)
        for i in range(n):
            pxor[i+1] = pxor[i] ^ arr[i]

        count = 0

        for i in range(n):
            for k in range(i, n):
                if pxor[i] == pxor[k+1]:
                    count += (k - i)

        return count