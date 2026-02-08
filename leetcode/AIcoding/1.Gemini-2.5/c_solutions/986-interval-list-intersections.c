int** intervalIntersection(int** firstList, int firstListSize, int* firstListColSize,
                           int** secondList, int secondListSize, int* secondListColSize,
                           int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * (firstListSize + secondListSize));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (firstListSize + secondListSize));
    *returnSize = 0;

    int i = 0, j = 0;

    while (i < firstListSize && j < secondListSize) {
        int start1 = firstList[i][0];
        int end1 = firstList[i][1];
        int start2 = secondList[j][0];
        int end2 = secondList[j][1];

        int intersectStart = (start1 > start2) ? start1 : start2;
        int intersectEnd = (end1 < end2) ? end1 : end2;

        if (intersectStart <= intersectEnd) {
            result[*returnSize] = (int*)malloc(sizeof(int) * 2);
            result[*returnSize][0] = intersectStart;
            result[*returnSize][1] = intersectEnd;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        }

        if (end1 < end2) {
            i++;
        } else {
            j++;
        }
    }

    return result;
}