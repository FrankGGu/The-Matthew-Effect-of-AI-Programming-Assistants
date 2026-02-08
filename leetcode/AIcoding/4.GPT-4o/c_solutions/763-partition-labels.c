int* partitionLabels(char * s, int* returnSize) {
    int last[26] = {0};
    for (int i = 0; s[i]; i++) {
        last[s[i] - 'a'] = i;
    }

    int* result = (int*)malloc(100 * sizeof(int));
    int start = 0, end = 0, idx = 0;

    for (int i = 0; s[i]; i++) {
        end = end > last[s[i] - 'a'] ? end : last[s[i] - 'a'];
        if (i == end) {
            result[idx++] = end - start + 1;
            start = end + 1;
        }
    }

    *returnSize = idx;
    return result;
}