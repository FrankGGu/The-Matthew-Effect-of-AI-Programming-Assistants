class Solution:
    def binaryGap(self, n: int) -> int:
        max_distance = 0
        last_one_position = -1
        current_position = 0

        while n > 0:
            if (n & 1) == 1:
                if last_one_position != -1:
                    max_distance = max(max_distance, current_position - last_one_position)
                last_one_position = current_position

            n >>= 1
            current_position += 1

        return max_distance