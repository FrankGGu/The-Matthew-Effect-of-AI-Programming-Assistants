char** findRelativeRanks(int* score, int scoreSize, int* returnSize) {
    char** ranks = (char**)malloc(scoreSize * sizeof(char*));
    int* sortedIndices = (int*)malloc(scoreSize * sizeof(int));
    for (int i = 0; i < scoreSize; i++) {
        sortedIndices[i] = i;
    }

    for (int i = 0; i < scoreSize - 1; i++) {
        for (int j = 0; j < scoreSize - i - 1; j++) {
            if (score[sortedIndices[j]] < score[sortedIndices[j + 1]]) {
                int temp = sortedIndices[j];
                sortedIndices[j] = sortedIndices[j + 1];
                sortedIndices[j + 1] = temp;
            }
        }
    }

    for (int i = 0; i < scoreSize; i++) {
        ranks[i] = (char*)malloc(16 * sizeof(char));
    }

    for (int i = 0; i < scoreSize; i++) {
        if (i == 0) {
            strcpy(ranks[sortedIndices[i]], "Gold Medal");
        } else if (i == 1) {
            strcpy(ranks[sortedIndices[i]], "Silver Medal");
        } else if (i == 2) {
            strcpy(ranks[sortedIndices[i]], "Bronze Medal");
        } else {
            sprintf(ranks[sortedIndices[i]], "%d", i + 1);
        }
    }

    *returnSize = scoreSize;
    free(sortedIndices);
    return ranks;
}