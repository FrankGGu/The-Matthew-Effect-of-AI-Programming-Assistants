class Solution:
    def maxChunksToSorted(self, arr: List[int]) -> int:
        max_left = []
        min_right = []

        current_max = float('-inf')
        for num in arr:
            current_max = max(current_max, num)
            max_left.append(current_max)

        current_min = float('inf')
        for num in reversed(arr):
            current_min = min(current_min, num)
            min_right.append(current_min)
        min_right = min_right[::-1]

        res = 0
        for i in range(len(arr) - 1):
            if max_left[i] <= min_right[i + 1]:
                res += 1

        return res + 1