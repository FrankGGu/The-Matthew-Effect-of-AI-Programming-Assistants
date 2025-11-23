class Solution:
    def binaryGap(self, n: int) -> int:
        max_gap = 0
        last_pos = None
        current_pos = 0

        while n > 0:
            if n & 1:
                if last_pos is not None:
                    max_gap = max(max_gap, current_pos - last_pos)
                last_pos = current_pos
            current_pos += 1
            n >>= 1

        return max_gap