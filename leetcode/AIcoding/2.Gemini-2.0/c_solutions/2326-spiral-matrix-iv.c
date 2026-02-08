#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int **spiralMatrix(int m, int n, struct ListNode *head, int *returnSize, int **returnColumnSizes) {
    int **matrix = (int **)malloc(m * sizeof(int *));
    *returnColumnSizes = (int *)malloc(m * sizeof(int));
    *returnSize = m;

    for (int i = 0; i < m; i++) {
        matrix[i] = (int *)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            matrix[i][j] = -1;
        }
    }

    int rowStart = 0, rowEnd = m - 1, colStart = 0, colEnd = n - 1;
    int dir = 0; // 0: right, 1: down, 2: left, 3: up

    while (head != NULL && rowStart <= rowEnd && colStart <= colEnd) {
        if (dir == 0) {
            for (int i = colStart; i <= colEnd && head != NULL; i++) {
                matrix[rowStart][i] = head->val;
                head = head->next;
            }
            rowStart++;
        } else if (dir == 1) {
            for (int i = rowStart; i <= rowEnd && head != NULL; i++) {
                matrix[i][colEnd] = head->val;
                head = head->next;
            }
            colEnd--;
        } else if (dir == 2) {
            for (int i = colEnd; i >= colStart && head != NULL; i--) {
                matrix[rowEnd][i] = head->val;
                head = head->next;
            }
            rowEnd--;
        } else if (dir == 3) {
            for (int i = rowEnd; i >= rowStart && head != NULL; i--) {
                matrix[i][colStart] = head->val;
                head = head->next;
            }
            colStart++;
        }
        dir = (dir + 1) % 4;
    }

    return matrix;
}