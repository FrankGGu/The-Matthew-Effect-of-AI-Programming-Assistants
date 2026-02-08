int minSwaps(char* s) {
    int open = 0, close = 0, swaps = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '[') {
            open++;
        } else {
            close++;
        }
        if (close > open) {
            swaps++;
            close--;
        }
    }
    return swaps;
}