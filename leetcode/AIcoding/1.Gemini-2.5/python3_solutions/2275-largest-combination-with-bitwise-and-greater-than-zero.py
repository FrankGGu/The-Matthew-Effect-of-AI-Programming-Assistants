class Solution:
    def largestCombination(self, candidates: list[int]) -> int:
        max_count = 0
        # Numbers are up to 10^7, which is less than 2^24.
        # So we need to check bits from 0 up to 23 (or 30 to be safe for general integers).
        for bit_pos in range(31):
            current_bit_count = 0
            for num in candidates:
                # Check if the bit_pos-th bit is set in num
                if (num >> bit_pos) & 1:
                    current_bit_count += 1
            max_count = max(max_count, current_bit_count)

        return max_count