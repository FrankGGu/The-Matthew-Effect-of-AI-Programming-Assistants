class Solution:
    def maximumSumQueries(self, A: List[int], B: List[int], queries: List[List[int]]) -> List[int]:
        n = len(A)
        paired = sorted(zip(A, B), key=lambda x: x[0] + x[1])
        max_sum = [0] * (n + 1)

        for i in range(n):
            max_sum[i + 1] = max(max_sum[i], paired[i][0] + paired[i][1])

        result = []
        for l, r in queries:
            l -= 1
            r -= 1
            result.append(max_sum[r + 1] if l == 0 else max_sum[r + 1] - max_sum[l])

        return result