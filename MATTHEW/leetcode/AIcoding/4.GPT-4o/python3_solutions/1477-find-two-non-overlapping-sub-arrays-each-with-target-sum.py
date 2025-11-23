class Solution:
    def minSumOfLengths(self, arr: List[int], target: int) -> int:
        n = len(arr)
        prefix_sum = {0: -1}
        current_sum = 0
        min_len = [float('inf')] * n
        result = float('inf')

        for i in range(n):
            current_sum += arr[i]
            if current_sum - target in prefix_sum:
                start_idx = prefix_sum[current_sum - target]
                length = i - start_idx
                if start_idx >= 0:
                    result = min(result, length + min_len[start_idx])
                min_len[i] = min(min_len[i - 1], length) if i > 0 else length
            else:
                min_len[i] = min_len[i - 1] if i > 0 else float('inf')
            prefix_sum[current_sum] = i

        return result if result != float('inf') else -1