/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** getLongestSubsequence(char** groups, int groupsSize, int* words, int wordsSize, int* returnSize) {
    char** res = (char**)malloc(groupsSize * sizeof(char*));
    int idx = 0;

    res[idx++] = groups[0];

    for (int i = 1; i < groupsSize; i++) {
        if (strcmp(groups[i], res[idx - 1]) != 0) {
            res[idx++] = groups[i];
        }
    }

    *returnSize = idx;
    return res;
}