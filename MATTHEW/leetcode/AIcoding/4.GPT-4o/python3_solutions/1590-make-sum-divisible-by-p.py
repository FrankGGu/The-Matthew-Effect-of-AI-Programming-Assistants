class Solution:
    def minSumOfLengths(self, arr: List[int], target: int) -> int:
        n = len(arr)
        min_length = [float('inf')] * (n + 1)
        current_sum = 0
        left = 0

        for right in range(n):
            current_sum += arr[right]
            while current_sum > target:
                current_sum -= arr[left]
                left += 1

            if current_sum == target:
                min_length[right + 1] = right - left + 1

        for i in range(1, n + 1):
            min_length[i] = min(min_length[i], min_length[i - 1])

        result = float('inf')
        current_sum = 0
        left = 0

        for right in range(n):
            current_sum += arr[right]
            while current_sum > target:
                current_sum -= arr[left]
                left += 1

            if current_sum == target:
                if left > 0:
                    result = min(result, right - left + 1 + min_length[left])

        return result if result != float('inf') else -1