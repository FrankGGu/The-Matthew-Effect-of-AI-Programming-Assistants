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
            index = self.first_greater_equal(arr, mid)
            current_sum = prefix_sum[index] + (n - index) * mid
            diff = abs(current_sum - target)

            if diff < min_diff:
                min_diff = diff
                best_value = mid
            elif diff == min_diff:
                best_value = min(best_value, mid)

            if current_sum > target:
                right = mid - 1
            else:
                left = mid + 1

        return best_value

    def first_greater_equal(self, arr: list[int], target: int) -> int:
        left, right = 0, len(arr) - 1
        ans = len(arr)
        while left <= right:
            mid = (left + right) // 2
            if arr[mid] >= target:
                ans = mid
                right = mid - 1
            else:
                left = mid + 1
        return ans