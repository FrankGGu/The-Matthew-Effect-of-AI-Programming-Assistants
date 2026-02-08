class Solution:
    def xorQueries(self, arr: List[int], queries: List[List[int]]) -> List[int]:
        n = len(arr)
        prefix_xor = [0] * (n + 1)

        for i in range(n):
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i]

        result = []
        for left, right in queries:
            result.append(prefix_xor[right + 1] ^ prefix_xor[left])

        return result