class Solution:
    def maximumWhiteTiles(self, tiles: list[list[int]], carpetLen: int) -> int:
        max_covered_length = 0
        current_sum = 0
        j = 0 # Right pointer for the tile window

        for i in range(len(tiles)):
            # C_start is the left end of the carpet, aligned with the start of tiles[i]
            C_start = tiles[i][0]
            # C_end is the right end of the carpet
            C_end = C_start + carpetLen - 1

            # Expand the window to the right (j) as long as tiles[j] starts within the carpet's reach
            while j < len(tiles) and tiles[j][0] <= C_end:
                # Add the full length of tiles[j] to current_sum
                current_sum += (tiles[j][1] - tiles[j][0] + 1)
                j += 1

            # At this point, current_sum holds the total length of tiles from tiles[i] to tiles[j-1].
            # These are all tiles whose start is less than or equal to C_end.
            # We need to adjust for the part of tiles[j-1] that might extend beyond C_end.

            current_total_covered = current_sum

            # If there's at least one tile in the window (j > i)
            # and the last tile added (tiles[j-1]) extends beyond the carpet's right end (C_end):
            # subtract the excess part of tiles[j-1]
            if j > i and tiles[j-1][1] > C_end:
                current_total_covered -= (tiles[j-1][1] - C_end)

            max_covered_length = max(max_covered_length, current_total_covered)

            # Before moving to the next iteration (i+1), remove tiles[i] from current_sum.
            # This is the full length of tiles[i].
            current_sum -= (tiles[i][1] - tiles[i][0] + 1)

        return max_covered_length