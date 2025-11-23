class Solution:
    def platesBetweenCandles(self, s: str, queries: List[List[int]]) -> List[int]:
        n = len(s)
        left_candle = [-1] * n
        right_candle = [-1] * n
        prefix_sum = [0] * (n + 1)

        # Precompute left_candle and prefix_sum
        last_candle = -1
        for i in range(n):
            if s[i] == '|':
                last_candle = i
            left_candle[i] = last_candle
            prefix_sum[i + 1] = prefix_sum[i] + (1 if s[i] == '*' else 0)

        # Precompute right_candle
        last_candle = -1
        for i in range(n - 1, -1, -1):
            if s[i] == '|':
                last_candle = i
            right_candle[i] = last_candle

        res = []
        for q in queries:
            l, r = q
            left = right_candle[l]
            right = left_candle[r]
            if left == -1 or right == -1 or left >= right:
                res.append(0)
            else:
                res.append(prefix_sum[right + 1] - prefix_sum[left])
        return res