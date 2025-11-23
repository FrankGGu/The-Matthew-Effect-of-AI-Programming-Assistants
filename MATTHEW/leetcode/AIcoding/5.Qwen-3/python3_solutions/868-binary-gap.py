class Solution:
    def binaryGap(self, n: int) -> int:
        max_gap = 0
        last_pos = -1
        for i in range(32):
            if (n >> i) & 1:
                if last_pos != -1:
                    max_gap = max(max_gap, i - last_pos)
                last_pos = i
        return max_gap