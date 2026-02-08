int numColorDecorations(int* lightColors, int lightColorsSize) {
    int count = 0;
    for (int i = 0; i < lightColorsSize; i++) {
        if (lightColors[i] == 1) {
            count++;
        }
    }
    return count;
}