class Solution:
    def xorQueries(self, arr: List[int], queries: List[List[int]]) -> List[int]:
        prefix_xor = [0] * (len(arr) + 1)
        for i in range(len(arr)):
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i]

        result = []
        for query in queries:
            start, end = query
            result.append(prefix_xor[end + 1] ^ prefix_xor[start])

        return result