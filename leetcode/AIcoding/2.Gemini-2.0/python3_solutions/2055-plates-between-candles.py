class Solution:
    def platesBetweenCandles(self, s: str, queries: list[list[int]]) -> list[int]:
        n = len(s)
        candle_indices = [i for i, c in enumerate(s) if c == '|']
        m = len(candle_indices)

        def find_nearest_left(target):
            left, right = 0, m - 1
            res = -1
            while left <= right:
                mid = (left + right) // 2
                if candle_indices[mid] <= target:
                    res = mid
                    left = mid + 1
                else:
                    right = mid - 1
            return res

        def find_nearest_right(target):
            left, right = 0, m - 1
            res = -1
            while left <= right:
                mid = (left + right) // 2
                if candle_indices[mid] >= target:
                    res = mid
                    right = mid - 1
                else:
                    left = mid + 1
            return res

        result = []
        for start, end in queries:
            left_candle = find_nearest_right(start)
            right_candle = find_nearest_left(end)

            if left_candle == -1 or right_candle == -1 or left_candle >= right_candle:
                result.append(0)
            else:
                left_index = candle_indices[left_candle]
                right_index = candle_indices[right_candle]

                plate_count = 0
                for i in range(left_index + 1, right_index):
                    if s[i] == '*':
                        plate_count += 1

                result.append(plate_count)

        return result