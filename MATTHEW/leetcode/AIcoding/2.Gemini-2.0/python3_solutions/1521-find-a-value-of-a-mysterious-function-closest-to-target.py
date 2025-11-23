class Solution:
    def findBestValue(self, arr: list[int], target: int) -> int:
        arr.sort()
        n = len(arr)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + arr[i]

        left, right = 0, max(arr)
        best_value = 0
        min_diff = float('inf')

        while left <= right:
            mid = (left + right) // 2

            index = self.binary_search(arr, mid)

            current_sum = prefix_sum[index] + (n - index) * mid

            diff = abs(current_sum - target)

            if diff < min_diff:
                min_diff = diff
                best_value = mid
            elif diff == min_diff and mid < best_value:
                best_value = mid

            if current_sum < target:
                left = mid + 1
            else:
                right = mid - 1

        return best_value

    def binary_search(self, arr, target):
        left, right = 0, len(arr) - 1
        while left <= right:
            mid = (left + right) // 2
            if arr[mid] < target:
                left = mid + 1
            else:
                right = mid - 1
        return left