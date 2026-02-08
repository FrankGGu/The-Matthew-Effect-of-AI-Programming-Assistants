bool containsPattern(int* arr, int arrSize, int m, int k) {
    int count = 0;
    for (int i = 0; i <= arrSize - m; i++) {
        count = 1;
        for (int j = i + m; j <= arrSize - m; j += m) {
            int match = 1;
            for (int p = 0; p < m; p++) {
                if (arr[i + p] != arr[j + p]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count++;
                if (count >= k) return true;
            } else {
                break;
            }
        }
    }
    return false;
}