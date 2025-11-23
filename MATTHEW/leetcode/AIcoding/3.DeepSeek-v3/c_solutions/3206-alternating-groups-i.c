int numberOfAlternatingGroups(int* colors, int colorsSize) {
    int count = 0;
    for (int i = 0; i < colorsSize; i++) {
        int left = (i - 1 + colorsSize) % colorsSize;
        int right = (i + 1) % colorsSize;
        if (colors[i] != colors[left] && colors[i] != colors[right]) {
            count++;
        }
    }
    return count;
}