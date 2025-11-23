class Solution:
    def numOfSubarrays(self, arr: list[int], k: int, threshold: int) -> int:
        count = 0
        n = len(arr)

        if n < k:
            return 0

        current_sum = 0
        for i in range(k):
            current_sum += arr[i]

        if current_sum >= k * threshold:
            count += 1

        for i in range(k, n):
            current_sum += arr[i] - arr[i - k]
            if current_sum >= k * threshold:
                count += 1

        return count