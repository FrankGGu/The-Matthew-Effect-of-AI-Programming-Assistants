class Solution:
    def maxChunksToSorted(self, arr: List[int]) -> int:
        n = len(arr)
        right_min = [0] * (n + 1)
        right_min[n] = float('inf')
        for i in range(n - 1, -1, -1):
            right_min[i] = min(right_min[i + 1], arr[i])

        left_max = float('-inf')
        count = 0
        for i in range(n):
            left_max = max(left_max, arr[i])
            if left_max <= right_min[i + 1]:
                count += 1

        return count