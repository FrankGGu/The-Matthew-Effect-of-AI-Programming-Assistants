int numSplits(char* s) {
    int left[26] = {0};
    int right[26] = {0};
    int leftCount = 0, rightCount = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        int idx = s[i] - 'a';
        if (right[idx] == 0) {
            rightCount++;
        }
        right[idx]++;
    }

    int result = 0;
    for (int i = 0; i < len - 1; i++) {
        int idx = s[i] - 'a';
        if (left[idx] == 0) {
            leftCount++;
        }
        left[idx]++;

        right[idx]--;
        if (right[idx] == 0) {
            rightCount--;
        }

        if (leftCount == rightCount) {
            result++;
        }
    }

    return result;
}