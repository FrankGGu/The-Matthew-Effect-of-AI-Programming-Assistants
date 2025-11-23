int countAlternatingGroups(int* colors, int colorsSize) {
    int count = 0;
    for (int i = 0; i < colorsSize; i++) {
        int c1 = colors[i];
        int c2 = colors[(i + 1) % colorsSize];
        int c3 = colors[(i + 2) % colorsSize];

        if (c1 != c2 && c2 != c3) {
            count++;
        }
    }
    return count;
}