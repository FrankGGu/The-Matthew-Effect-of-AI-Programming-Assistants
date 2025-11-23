class Solution:
    def xorQueries(self, arr: list[int], queries: list[list[int]]) -> list[int]:
        n = len(arr)
        prefix_xor = [0] * (n + 1)
        for i in range(n):
            prefix_xor[i+1] = prefix_xor[i] ^ arr[i]

        results = []
        for L, R in queries:
            results.append(prefix_xor[R+1] ^ prefix_xor[L])

        return results