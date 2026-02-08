/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** findRelativeRanks(int* score, int scoreSize, int* returnSize) {
    *returnSize = scoreSize;
    char** result = (char**)malloc(scoreSize * sizeof(char*));
    int* indices = (int*)malloc(scoreSize * sizeof(int));

    for (int i = 0; i < scoreSize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < scoreSize - 1; i++) {
        for (int j = i + 1; j < scoreSize; j++) {
            if (score[indices[i]] < score[indices[j]]) {
                int temp = indices[i];
                indices[i] = indices[j];
                indices[j] = temp;
            }
        }
    }

    for (int i = 0; i < scoreSize; i++) {
        if (i == 0) {
            result[indices[i]] = (char*)malloc(13 * sizeof(char));
            strcpy(result[indices[i]], "Gold Medal");
        } else if (i == 1) {
            result[indices[i]] = (char*)malloc(14 * sizeof(char));
            strcpy(result[indices[i]], "Silver Medal");
        } else if (i == 2) {
            result[indices[i]] = (char*)malloc(14 * sizeof(char));
            strcpy(result[indices[i]], "Bronze Medal");
        } else {
            result[indices[i]] = (char*)malloc(6 * sizeof(char));
            sprintf(result[indices[i]], "%d", i + 1);
        }
    }

    free(indices);
    return result;
}