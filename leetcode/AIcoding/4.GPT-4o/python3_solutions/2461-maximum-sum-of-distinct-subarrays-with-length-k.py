class Solution:
    def maximumSum(self, arr: List[int], k: int) -> int:
        n = len(arr)
        if n < k:
            return 0

        current_sum = sum(arr[:k])
        max_sum = current_sum

        seen = set(arr[:k])

        for i in range(k, n):
            current_sum += arr[i] - arr[i - k]
            if arr[i] in seen or arr[i - k] not in seen:
                continue
            seen.add(arr[i])
            seen.remove(arr[i - k])
            max_sum = max(max_sum, current_sum)

        return max_sum