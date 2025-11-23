class Solution:
    def maxChunksToSorted(self, arr: list[int]) -> int:
        n = len(arr)
        if n == 0:
            return 0

        left_max = [0] * n
        right_min = [0] * n

        left_max[0] = arr[0]
        for i in range(1, n):
            left_max[i] = max(left_max[i-1], arr[i])

        right_min[n-1] = arr[n-1]
        for i in range(n - 2, -1, -1):
            right_min[i] = min(right_min[i+1], arr[i])

        chunks = 1
        for i in range(n - 1):
            if left_max[i] <= right_min[i+1]:
                chunks += 1

        return chunks