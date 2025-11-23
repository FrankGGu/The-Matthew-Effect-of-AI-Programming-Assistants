class Solution:
    def findLengthOfShortestSubarray(self, arr: List[int]) -> int:
        n = len(arr)
        left = [0] * n
        right = [0] * n

        left[0] = 1
        for i in range(1, n):
            left[i] = left[i - 1] + 1 if arr[i] >= arr[i - 1] else 1

        right[n - 1] = 1
        for i in range(n - 2, -1, -1):
            right[i] = right[i + 1] + 1 if arr[i] <= arr[i + 1] else 1

        max_left = 0
        for i in range(n):
            max_left = max(max_left, left[i])
            if i + 1 < n and arr[i] <= arr[i + 1]:
                continue
            max_left = left[i]
            break

        min_length = n
        for i in range(n):
            if i > 0:
                min_length = min(min_length, n - left[i - 1])
            if i < n - 1:
                min_length = min(min_length, n - right[i + 1])

        for i in range(n):
            if i < n - 1 and arr[i] <= arr[i + 1]:
                j = 0
                while j < n and arr[i] >= arr[j]:
                    j += 1
                if j < n:
                    min_length = min(min_length, j - i - 1)

        return min_length