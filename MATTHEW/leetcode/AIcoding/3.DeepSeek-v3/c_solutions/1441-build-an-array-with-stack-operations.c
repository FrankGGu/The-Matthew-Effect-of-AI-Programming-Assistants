/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** buildArray(int* target, int targetSize, int n, int* returnSize) {
    char **result = (char**)malloc(sizeof(char*) * (n * 2));
    int index = 0;
    int current = 1;

    for (int i = 0; i < targetSize; i++) {
        while (current < target[i]) {
            result[index] = (char*)malloc(5 * sizeof(char));
            strcpy(result[index++], "Push");

            result[index] = (char*)malloc(5 * sizeof(char));
            strcpy(result[index++], "Pop");

            current++;
        }

        result[index] = (char*)malloc(5 * sizeof(char));
        strcpy(result[index++], "Push");

        current++;
    }

    *returnSize = index;
    return result;
}