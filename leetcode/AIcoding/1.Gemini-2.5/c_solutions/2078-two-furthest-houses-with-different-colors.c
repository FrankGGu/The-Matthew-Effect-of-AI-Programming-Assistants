int maxDistance(int* colors, int colorsSize) {
    int max_dist = 0;

    // Find the maximum distance from house 0 to any house j with a different color.
    // Iterate from the rightmost house towards house 0.
    for (int j = colorsSize - 1; j >= 0; j--) {
        if (colors[j] != colors[0]) {
            max_dist = j; // Distance is j - 0
            break; // Found the furthest house, no need to check further
        }
    }

    // Find the maximum distance from house colorsSize - 1 to any house i with a different color.
    // Iterate from house 0 towards the rightmost house.
    for (int i = 0; i < colorsSize; i++) {
        if (colors[i] != colors[colorsSize - 1]) {
            int current_dist = (colorsSize - 1) - i;
            if (current_dist > max_dist) {
                max_dist = current_dist;
            }
            break; // Found the furthest house, no need to check further
        }
    }

    return max_dist;
}