/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** spiralMatrixIII(int rows, int cols, int rStart, int cStart, int* returnSize, int** returnColumnSizes) {
    int total = rows * cols;
    int** result = (int**)malloc(total * sizeof(int*));
    *returnColumnSizes = (int*)malloc(total * sizeof(int));
    *returnSize = total;

    for (int i = 0; i < total; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        (*returnColumnSizes)[i] = 2;
    }

    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int r = rStart, c = cStart;
    int step = 1, dir = 0;
    int count = 0;

    result[count][0] = r;
    result[count][1] = c;
    count++;

    while (count < total) {
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < step; j++) {
                r += directions[dir][0];
                c += directions[dir][1];

                if (r >= 0 && r < rows && c >= 0 && c < cols) {
                    result[count][0] = r;
                    result[count][1] = c;
                    count++;
                    if (count == total) {
                        return result;
                    }
                }
            }
            dir = (dir + 1) % 4;
        }
        step++;
    }

    return result;
}