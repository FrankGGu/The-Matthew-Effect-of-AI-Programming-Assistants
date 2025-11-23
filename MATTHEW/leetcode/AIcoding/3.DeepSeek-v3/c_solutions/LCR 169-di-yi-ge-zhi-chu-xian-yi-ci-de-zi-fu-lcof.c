int dismantlingAction(char* arr) {
    int last[26];
    for (int i = 0; i < 26; i++) last[i] = -1;
    int n = strlen(arr);
    int start = -1;
    int maxLen = 0;
    for (int i = 0; i < n; i++) {
        int idx = arr[i] - 'a';
        if (last[idx] > start) {
            start = last[idx];
        }
        last[idx] = i;
        if (i - start > maxLen) {
            maxLen = i - start;
        }
    }
    return maxLen;
}