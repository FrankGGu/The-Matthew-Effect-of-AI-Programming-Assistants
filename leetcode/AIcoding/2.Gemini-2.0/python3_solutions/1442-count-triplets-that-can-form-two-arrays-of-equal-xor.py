class Solution:
    def countTriplets(self, arr: List[int]) -> int:
        n = len(arr)
        count = 0
        for i in range(n - 1):
            xor_val = arr[i]
            for j in range(i + 1, n):
                xor_val ^= arr[j]
                if xor_val == 0:
                    count += (j - i)
        return count