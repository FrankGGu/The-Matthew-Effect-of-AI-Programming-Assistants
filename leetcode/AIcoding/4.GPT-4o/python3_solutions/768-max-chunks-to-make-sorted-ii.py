class Solution:
    def maxChunksToSorted(self, arr: List[int]) -> int:
        n = len(arr)
        max_left = [0] * n
        min_right = [0] * n

        max_left[0] = arr[0]
        for i in range(1, n):
            max_left[i] = max(max_left[i - 1], arr[i])

        min_right[n - 1] = arr[n - 1]
        for i in range(n - 2, -1, -1):
            min_right[i] = min(min_right[i + 1], arr[i])

        chunks = 0
        for i in range(n - 1):
            if max_left[i] <= min_right[i + 1]:
                chunks += 1

        return chunks + 1