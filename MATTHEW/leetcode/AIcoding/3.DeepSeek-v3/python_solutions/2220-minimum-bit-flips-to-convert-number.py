class Solution:
    def minBitFlips(self, start: int, goal: int) -> int:
        xor = start ^ goal
        count = 0
        while xor:
            count += xor & 1
            xor >>= 1
        return count