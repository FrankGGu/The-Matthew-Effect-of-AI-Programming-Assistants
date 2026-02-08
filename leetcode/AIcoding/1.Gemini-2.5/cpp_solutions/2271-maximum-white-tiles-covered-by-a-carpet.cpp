#include <vector>
#include <algorithm>

class Solution {
public:
    long long maximumWhiteTiles(std::vector<std::vector<int>>& tiles, int carpetLen) {
        // The problem statement guarantees tiles are sorted by li.
        // No explicit sort is needed.

        long long max_covered_tiles = 0;
        long long current_covered_tiles = 0;
        int left = 0;
        int n = tiles.size();

        for (int right = 0; right < n; ++right) {
            // Add the full length of tiles[right] to current_covered_tiles
            current_covered_tiles += (tiles[right][1] - tiles[right][0] + 1);

            // Calculate the potential start position of the carpet
            // if its right end is tiles[right][1]
            long long carpet_start_pos = (long long)tiles[right][1] - carpetLen + 1;

            // Adjust the left pointer to ensure tiles[left] is the first tile
            // that is potentially covered by the carpet.
            // The loop continues as long as tiles[left] starts completely to the left
            // of the carpet's current start position.
            while (tiles[left][0] < carpet_start_pos) {
                // If tiles[left] is entirely to the left of the carpet's current range
                if (tiles[left][1] < carpet_start_pos) {
                    current_covered_tiles -= (tiles[left][1] - tiles[left][0] + 1);
                    left++;
                } else {
                    // tiles[left] partially overlaps the carpet from its left side.
                    // This means tiles[left][0] < carpet_start_pos <= tiles[left][1].
                    // We keep tiles[left] as the leftmost tile, and will subtract the uncovered part later.
                    break;
                }
            }

            // 'current_covered_tiles' now holds the sum of lengths of tiles from 'left' to 'right',
            // assuming they are fully covered.
            long long current_val = current_covered_tiles;

            // If tiles[left] is partially covered from its left side
            // (i.e., tiles[left][0] is less than carpet_start_pos)
            if (tiles[left][0] < carpet_start_pos) {
                // Subtract the part of tiles[left] that is not covered by the carpet.
                // This part is (carpet_start_pos - tiles[left][0]).
                current_val -= (carpet_start_pos - tiles[left][0]);
            }

            max_covered_tiles = std::max(max_covered_tiles, current_val);
        }

        return max_covered_tiles;
    }
};