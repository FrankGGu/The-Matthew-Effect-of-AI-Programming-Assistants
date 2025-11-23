/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maxDepthAfterSplit(char* seq, int* returnSize) {
    int len = strlen(seq);
    int* res = (int*)malloc(len * sizeof(int));
    *returnSize = len;
    int depth = 0;

    for (int i = 0; i < len; i++) {
        if (seq[i] == '(') {
            depth++;
            res[i] = depth % 2;
        } else {
            res[i] = depth % 2;
            depth--;
        }
    }

    return res;
}