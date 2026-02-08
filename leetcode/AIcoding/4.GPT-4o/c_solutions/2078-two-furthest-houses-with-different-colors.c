int maxDistance(int* colors, int colorsSize) {
    int left = 0, right = colorsSize - 1;
    while (colors[left] == colors[0]) left++;
    while (colors[right] == colors[colorsSize - 1]) right--;
    return right > left ? right : colorsSize - 1 - left;
}