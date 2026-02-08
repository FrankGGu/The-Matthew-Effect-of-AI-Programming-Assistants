int maxLength(char** arr, int arrSize) {
    int* masks = (int*)malloc(arrSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        char* s = arr[i];
        int mask = 0;
        int valid = 1;
        for (int j = 0; s[j] != '\0'; j++) {
            int bit = 1 << (s[j] - 'a');
            if (mask & bit) {
                valid = 0;
                break;
            }
            mask |= bit;
        }
        if (valid) {
            masks[count++] = mask;
        }
    }

    int maxLen = 0;

    void backtrack(int idx, int currentMask, int currentLen) {
        if (idx == count) {
            if (currentLen > maxLen) {
                maxLen = currentLen;
            }
            return;
        }

        if ((masks[idx] & currentMask) == 0) {
            backtrack(idx + 1, currentMask | masks[idx], currentLen + __builtin_popcount(masks[idx]));
        }

        backtrack(idx + 1, currentMask, currentLen);
    }

    backtrack(0, 0, 0);
    free(masks);
    return maxLen;
}