#include <stdlib.h>

int advancePointer(int* r_ptr, int* c_ptr, int* dir_ptr, int m, int n) {
    int r = *r_ptr;
    int c = *c_ptr;
    int dir = *dir_ptr;

    if (dir == 1) {
        r--;
        c++;
        if (r < 0 || c >= n) {
            r++;
            c--;
            if (c + 1 < n) {
                c++;
            } else {
                r++;
            }
            dir = -1;
        }
    } else {
        r++;
        c--;
        if (r >= m || c < 0) {
            r--;
            c++;
            if (r + 1 < m) {
                r++;
            } else {
                c++;
            }
            dir = 1;
        }
    }

    if (r >= m || c >= n) {
        return 0;
    }

    *r_ptr = r;
    *c_ptr = c;
    *dir_ptr = dir;
    return 1;
}

int* zigzagTraversalWithSkip(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    if (gridSize == 0 || gridColSize == NULL || gridColSize[0] == 0) {
        *returnSize = 0;
        return NULL;
    }

    int m = gridSize;
    int n = gridColSize[0];

    int maxElements = m * n;
    int* result = (int*)malloc(sizeof(int) * maxElements);
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int currentResultIdx = 0;
    int r = 0, c = 0;
    int dir = 1;

    while (1) {
        result[currentResultIdx++] = grid[r][c];
        int skip_val = grid[r][c];

        for (int i = 0; i < skip_val; ++i) {
            if (!advancePointer(&r, &c, &dir, m, n)) {
                goto end_traversal;
            }
        }

        if (!advancePointer(&r, &c, &dir, m, n)) {
            goto end_traversal;
        }
    }

end_traversal:
    *returnSize = currentResultIdx;
    return result;
}