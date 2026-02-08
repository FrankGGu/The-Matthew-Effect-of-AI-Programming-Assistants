bool canRemoveColoredPieces(char *colors, int colorsSize) {
    int count = 0;
    for (int i = 0; i < colorsSize; i++) {
        if (i > 0 && i < colorsSize - 1 && colors[i] == colors[i - 1] && colors[i] == colors[i + 1]) {
            count++;
            i++;
        }
    }
    return count % 2 == 0;
}