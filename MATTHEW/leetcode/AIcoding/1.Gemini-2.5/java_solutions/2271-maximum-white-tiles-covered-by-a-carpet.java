import java.util.Arrays;

class Solution {
    public long maximumWhiteTiles(int[][] tiles, int carpetLen) {
        // Sort tiles by their start position
        Arrays.sort(tiles, (a, b) -> a[0] - b[0]);

        long maxCover = 0;
        long currentCover = 0;
        int j = 0; // Right pointer for the window of tiles

        for (int i = 0; i < tiles.length; i++) {
            // Calculate the rightmost coordinate (exclusive) that the carpet can reach
            // if its left edge is at tiles[i][0].
            long carpetRightExclusive = (long)tiles[i][0] + carpetLen;

            // Expand the window with 'j' to include all tiles that start before carpetRightExclusive.
            // Add their full lengths to currentCover.
            while (j < tiles.length && tiles[j][0] < carpetRightExclusive) {
                currentCover += (tiles[j][1] - tiles[j][0] + 1);
                j++;
            }

            // At this point, currentCover holds the sum of lengths of tiles[i] through tiles[j-1].
            // This sum might include parts of tiles that extend beyond the carpet's right edge.
            // We need to adjust for the partial coverage of the rightmost tile (tiles[j-1]).

            long coveredByCurrentCarpet = currentCover;

            // If j > 0, it means at least one tile (tiles[j-1]) was added to the window.
            // Check if the last tile added (tiles[j-1]) extends beyond the carpet's right end.
            // The carpet covers coordinates up to carpetRightExclusive - 1 (inclusive).
            if (j > 0 && tiles[j-1][1] >= carpetRightExclusive) {
                // If it extends, subtract the excess part.
                // The excess part is tiles[j-1][1] - (carpetRightExclusive - 1).
                coveredByCurrentCarpet -= (tiles[j-1][1] - (carpetRightExclusive - 1));
            }

            maxCover = Math.max(maxCover, coveredByCurrentCarpet);

            // Shrink the window by removing tiles[i] from currentCover as we move to the next 'i'.
            currentCover -= (tiles[i][1] - tiles[i][0] + 1);
        }

        return maxCover;
    }
}