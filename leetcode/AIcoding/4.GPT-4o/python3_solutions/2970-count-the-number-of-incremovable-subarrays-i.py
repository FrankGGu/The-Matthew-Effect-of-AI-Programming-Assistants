class Solution:
    def countIncremovableSubarrays(self, arr: List[int]) -> int:
        n = len(arr)
        left = [0] * n
        right = [0] * n

        for i in range(n):
            if i == 0 or arr[i] > arr[i - 1]:
                left[i] = 1
            else:
                left[i] = left[i - 1] + 1

        for i in range(n - 1, -1, -1):
            if i == n - 1 or arr[i] < arr[i + 1]:
                right[i] = 1
            else:
                right[i] = right[i + 1] + 1

        total_incremovable = 0
        for i in range(n):
            total_incremovable += left[i] + right[i] - 1

        return n - total_incremovable