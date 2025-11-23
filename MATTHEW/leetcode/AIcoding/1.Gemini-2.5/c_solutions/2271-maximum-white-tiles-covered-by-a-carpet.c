#include <stdlib.h> // For qsort

long long long_max(long long a, long long b) {
    return a > b ? a : b;
}

int compareTiles(const void* a, const void* b) {
    const int* tileA = *(const int**)a;
    const int* tileB = *(const int**)b;
    // Sort by start position (tiles[i][0])
    return tileA[0] - tileB[0];
}

int maximumWhiteTiles(int** tiles, int tilesSize, int* tilesColSize, int carpetLen) {
    // Sort the tiles based on their starting positions
    qsort(tiles, tilesSize, sizeof(int*), compareTiles);

    long long current_sum_of_full_tiles = 0; // Sum of lengths of tiles from left_ptr to right
    long long max_covered = 0;
    int left_ptr = 0;

    for (int right = 0; right < tilesSize; ++right) {
        // Add the current tile's full length to the running sum
        current_sum_of_full_tiles += (tiles[right][1] - tiles[right][0] + 1);

        // Calculate the potential start position of the carpet if its right edge is at tiles[right][1]
        long long carpet_left_edge = (long long)tiles[right][1] - carpetLen + 1;

        // While the tile at left_ptr is completely to the left of the carpet's left edge,
        // remove its full length from the sum and advance left_ptr.
        while (tiles[left_ptr][1] < carpet_left_edge) {
            current_sum_of_full_tiles -= (tiles[left_ptr][1] - tiles[left_ptr][0] + 1);
            left_ptr++;
        }

        // At this point, tiles[left_ptr] is the first tile that potentially overlaps with the carpet.
        // `current_sum_of_full_tiles` now contains the sum of lengths of tiles from `left_ptr` to `right`.
        // `tiles[left_ptr]` might be partially covered.
        // The part of `tiles[left_ptr]` that is NOT covered by the carpet is `long_max(0, carpet_left_edge - tiles[left_ptr][0])`.
        // This `long_max(0, ...)` handles cases where `carpet_left_edge` is before `tiles[left_ptr][0]`, meaning `tiles[left_ptr]` is fully covered from its start.

        long long current_coverage = current_sum_of_full_tiles - long_max(0LL, carpet_left_edge - tiles[left_ptr][0]);

        // Update the maximum covered tiles
        max_covered = long_max(max_covered, current_coverage);
    }

    return (int)max_covered;
}