class Solution:
    def numOfSubarrays(self, arr: list[int], k: int, threshold: int) -> int:
        n = len(arr)
        if n < k:
            return 0

        target_sum = k * threshold

        current_sum = sum(arr[:k])
        count = 0

        if current_sum >= target_sum:
            count += 1

        for i in range(k, n):
            current_sum += arr[i] - arr[i - k]
            if current_sum >= target_sum:
                count += 1

        return count