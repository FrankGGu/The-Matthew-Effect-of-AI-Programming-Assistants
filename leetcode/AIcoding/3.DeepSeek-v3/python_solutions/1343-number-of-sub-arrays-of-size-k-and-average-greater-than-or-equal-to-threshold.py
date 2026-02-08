class Solution:
    def numOfSubarrays(self, arr: List[int], k: int, threshold: int) -> int:
        total = 0
        current_sum = sum(arr[:k])
        if current_sum / k >= threshold:
            total += 1

        for i in range(k, len(arr)):
            current_sum += arr[i] - arr[i - k]
            if current_sum / k >= threshold:
                total += 1

        return total