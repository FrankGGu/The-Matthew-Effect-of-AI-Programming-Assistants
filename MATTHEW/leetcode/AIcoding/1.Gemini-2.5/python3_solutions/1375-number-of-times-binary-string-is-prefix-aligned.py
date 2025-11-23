class Solution:
    def numTimesAllBlue(self, flips: list[int]) -> int:
        max_val_seen = 0
        aligned_moments = 0
        for i, flip_val in enumerate(flips):
            max_val_seen = max(max_val_seen, flip_val)
            # The number of bits turned on so far is (i + 1)
            if max_val_seen == (i + 1):
                aligned_moments += 1
        return aligned_moments