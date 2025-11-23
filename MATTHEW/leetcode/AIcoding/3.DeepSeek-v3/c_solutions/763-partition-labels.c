/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* partitionLabels(char* s, int* returnSize) {
    int last[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        last[s[i] - 'a'] = i;
    }

    int* result = malloc(len * sizeof(int));
    int start = 0, end = 0;
    *returnSize = 0;

    for (int i = 0; i < len; i++) {
        end = fmax(end, last[s[i] - 'a']);
        if (i == end) {
            result[(*returnSize)++] = end - start + 1;
            start = i + 1;
        }
    }

    return result;
}