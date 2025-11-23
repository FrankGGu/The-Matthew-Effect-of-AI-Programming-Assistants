class Solution:
    def minimumSecondsToMakeMountainHeightZero(self, mountain: List[int]) -> int:
        n = len(mountain)
        left = [0] * n
        right = [0] * n

        for i in range(1, n):
            if mountain[i] > mountain[i-1]:
                left[i] = left[i-1] + 1
            else:
                left[i] = left[i-1]

        for i in range(n-2, -1, -1):
            if mountain[i] > mountain[i+1]:
                right[i] = right[i+1] + 1
            else:
                right[i] = right[i+1]

        min_seconds = float('inf')
        for i in range(n):
            if left[i] + right[i] < min_seconds:
                min_seconds = left[i] + right[i]

        return min_seconds