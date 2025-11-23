class Solution:
    def maximumSum(self, arr: List[int], k: int) -> int:
        n = len(arr)
        if n == 0 or k == 0:
            return 0

        freq = {}
        max_sum = 0
        current_sum = 0
        left = 0

        for right in range(n):
            current_sum += arr[right]
            freq[arr[right]] = freq.get(arr[right], 0) + 1

            while freq[arr[right]] > 1:
                freq[arr[left]] -= 1
                if freq[arr[left]] == 0:
                    del freq[arr[left]]
                current_sum -= arr[left]
                left += 1

            if right - left + 1 == k:
                max_sum = max(max_sum, current_sum)

        return max_sum