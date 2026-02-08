int maxDistance(int* colors, int colorsSize) {
    int maxDist = 0;
    for (int i = 0; i < colorsSize; i++) {
        for (int j = i + 1; j < colorsSize; j++) {
            if (colors[i] != colors[j]) {
                int dist = j - i;
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
        }
    }
    return maxDist;
}