class Solution:
    def longestButtonPress(self, buttons: str) -> int:
        max_time = 0
        current_time = 0
        prev_char = None

        for char in buttons:
            if char == prev_char:
                current_time += 1
            else:
                current_time = 1
                prev_char = char
            max_time = max(max_time, current_time)

        return max_time