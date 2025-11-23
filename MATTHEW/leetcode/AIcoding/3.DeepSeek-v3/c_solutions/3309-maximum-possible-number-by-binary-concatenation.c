int compare(const void *a, const void *b) {
    char str1[50], str2[50];
    sprintf(str1, "%d%d", *(int*)a, *(int*)b);
    sprintf(str2, "%d%d", *(int*)b, *(int*)a);
    return strcmp(str2, str1);
}

int maxConcatenatedNumber(int* nums, int numsSize) {
    char** strNums = (char**)malloc(numsSize * sizeof(char*));
    for (int i = 0; i < numsSize; i++) {
        strNums[i] = (char*)malloc(12 * sizeof(char));
        sprintf(strNums[i], "%d", nums[i]);
    }

    qsort(strNums, numsSize, sizeof(char*), compare);

    char result[500] = "";
    for (int i = 0; i < numsSize; i++) {
        strcat(result, strNums[i]);
        free(strNums[i]);
    }
    free(strNums);

    return atoi(result);
}