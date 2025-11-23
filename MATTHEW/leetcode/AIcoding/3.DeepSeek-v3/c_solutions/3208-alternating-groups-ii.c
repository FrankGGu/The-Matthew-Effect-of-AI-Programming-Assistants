int numberOfAlternatingGroups(int* colors, int colorsSize, int k) {
    int n = colorsSize;
    int result = 0;

    for (int i = 0; i < n; i++) {
        int valid = 1;
        for (int j = 0; j < k - 1; j++) {
            int idx1 = (i + j) % n;
            int idx2 = (i + j + 1) % n;
            if (colors[idx1] == colors[idx2]) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            result++;
        }
    }

    return result;
}