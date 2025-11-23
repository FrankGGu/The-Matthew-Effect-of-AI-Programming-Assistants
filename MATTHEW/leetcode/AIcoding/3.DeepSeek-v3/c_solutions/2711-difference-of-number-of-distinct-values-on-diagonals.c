/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** differenceOfDistinctValues(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int** answer = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        answer[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int topLeftCount = 0;
            int bottomRightCount = 0;

            int hashTopLeft[51] = {0};
            int r = i - 1, c = j - 1;
            while (r >= 0 && c >= 0) {
                if (hashTopLeft[grid[r][c]] == 0) {
                    hashTopLeft[grid[r][c]] = 1;
                    topLeftCount++;
                }
                r--;
                c--;
            }

            int hashBottomRight[51] = {0};
            r = i + 1;
            c = j + 1;
            while (r < m && c < n) {
                if (hashBottomRight[grid[r][c]] == 0) {
                    hashBottomRight[grid[r][c]] = 1;
                    bottomRightCount++;
                }
                r++;
                c++;
            }

            answer[i][j] = abs(topLeftCount - bottomRightCount);
        }
    }

    return answer;
}