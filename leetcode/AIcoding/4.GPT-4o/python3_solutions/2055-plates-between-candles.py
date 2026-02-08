class Solution:
    def platesBetweenCandles(self, s: str, queries: List[List[int]]) -> List[int]:
        n = len(s)
        prefix_sum = [0] * (n + 1)
        left_candle = [-1] * n
        right_candle = [-1] * n

        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + (s[i] == '|')

        for i in range(n):
            if s[i] == '|':
                left_candle[i] = i
            elif i > 0:
                left_candle[i] = left_candle[i - 1]

        for i in range(n - 1, -1, -1):
            if s[i] == '|':
                right_candle[i] = i
            elif i < n - 1:
                right_candle[i] = right_candle[i + 1]

        result = []
        for start, end in queries:
            left = right_candle[start]
            right = left_candle[end]
            if left == -1 or right == -1 or left >= right:
                result.append(0)
            else:
                result.append((right - left - 1) - (prefix_sum[right + 1] - prefix_sum[left + 1]))

        return result