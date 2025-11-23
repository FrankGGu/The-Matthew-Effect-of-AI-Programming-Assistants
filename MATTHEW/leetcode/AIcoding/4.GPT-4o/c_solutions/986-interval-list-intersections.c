#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int** intervalIntersection(int** A, int ASize, int* AColSize, int** B, int BSize, int* BColSize, int* returnSize, int** returnColumnSizes) {
    int **result = (int **)malloc(sizeof(int *) * (ASize + BSize));
    *returnSize = 0;
    *returnColumnSizes = (int *)malloc(sizeof(int) * (ASize + BSize));

    int i = 0, j = 0;
    while (i < ASize && j < BSize) {
        int start = MAX(A[i][0], B[j][0]);
        int end = MIN(A[i][1], B[j][1]);

        if (start <= end) {
            result[*returnSize] = (int *)malloc(sizeof(int) * 2);
            result[*returnSize][0] = start;
            result[*returnSize][1] = end;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        }

        if (A[i][1] < B[j][1]) {
            i++;
        } else {
            j++;
        }
    }

    return result;
}