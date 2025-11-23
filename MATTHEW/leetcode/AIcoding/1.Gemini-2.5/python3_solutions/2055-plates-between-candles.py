import bisect

class Solution:
    def platesBetweenCandles(self, s: str, queries: list[list[int]]) -> list[int]:
        n = len(s)

        candle_indices = []
        for i in range(n):
            if s[i] == '|':
                candle_indices.append(i)

        prefix_plates = [0] * (n + 1)
        count = 0
        for i in range(n):
            if s[i] == '*':
                count += 1
            prefix_plates[i+1] = count

        results = []
        for start, end in queries:
            left_candle_idx_in_list = bisect.bisect_left(candle_indices, start)
            right_candle_idx_in_list = bisect.bisect_right(candle_indices, end) - 1

            if left_candle_idx_in_list >= right_candle_idx_in_list:
                results.append(0)
            else:
                first_candle_pos = candle_indices[left_candle_idx_in_list]
                last_candle_pos = candle_indices[right_candle_idx_in_list]

                plates_count = prefix_plates[last_candle_pos] - prefix_plates[first_candle_pos + 1]
                results.append(plates_count)

        return results