class Solution:
    def countPairs(self, colors: list[int], k: int) -> int:
        count = 0
        freq_map = {}

        for j in range(len(colors)):
            current_color = colors[j]
            current_remainder = j % k

            key = (current_color, current_remainder)

            if key in freq_map:
                count += freq_map[key]

            freq_map[key] = freq_map.get(key, 0) + 1

        return count