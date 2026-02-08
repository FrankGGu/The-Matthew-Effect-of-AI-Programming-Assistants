class Solution:
    def countTriplets(self, arr: List[int]) -> int:
        n = len(arr)
        prefix_xor = [0] * (n + 1)
        for i in range(n):
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i]

        count = 0
        for i in range(n):
            for j in range(i + 1, n + 1):
                if prefix_xor[i] == prefix_xor[j]:
                    count += j - i - 1

        return count