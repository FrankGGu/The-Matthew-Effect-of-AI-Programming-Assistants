class Solution:
    def longestWPI(self, hours: list[int]) -> int:
        prefix_sum = 0
        max_length = 0
        prefix_sum_map = {0: -1}
        for i, hour in enumerate(hours):
            if hour > 8:
                prefix_sum += 1
            else:
                prefix_sum -= 1
            if prefix_sum > 0:
                max_length = i + 1
            else:
                if prefix_sum - 1 in prefix_sum_map:
                    max_length = max(max_length, i - prefix_sum_map[prefix_sum - 1])
                if prefix_sum not in prefix_sum_map:
                    prefix_sum_map[prefix_sum] = i
        return max_length