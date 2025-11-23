class Solution:
    def countTriplets(self, arr: list[int]) -> int:
        n = len(arr)
        count = 0
        for i in range(n):
            for j in range(i + 1, n):
                for k in range(j + 1, n):
                    if arr[i] ^ arr[j] ^ arr[k] == 0:
                        count += 1
        return count