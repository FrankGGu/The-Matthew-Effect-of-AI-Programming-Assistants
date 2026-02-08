/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** intervalIntersection(int** firstList, int firstListSize, int* firstListColSize, int** secondList, int secondListSize, int* secondListColSize, int* returnSize, int** returnColumnSizes) {
    int** result = malloc((firstListSize + secondListSize) * sizeof(int*));
    *returnColumnSizes = malloc((firstListSize + secondListSize) * sizeof(int));
    *returnSize = 0;

    int i = 0, j = 0;

    while (i < firstListSize && j < secondListSize) {
        int low = firstList[i][0] > secondList[j][0] ? firstList[i][0] : secondList[j][0];
        int high = firstList[i][1] < secondList[j][1] ? firstList[i][1] : secondList[j][1];

        if (low <= high) {
            result[*returnSize] = malloc(2 * sizeof(int));
            result[*returnSize][0] = low;
            result[*returnSize][1] = high;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        }

        if (firstList[i][1] < secondList[j][1]) {
            i++;
        } else {
            j++;
        }
    }

    return result;
}