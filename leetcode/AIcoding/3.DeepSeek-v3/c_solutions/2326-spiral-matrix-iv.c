/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** spiralMatrix(int m, int n, struct ListNode* head, int* returnSize, int** returnColumnSizes) {
    int** matrix = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        matrix[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            matrix[i][j] = -1;
        }
    }

    int top = 0, bottom = m - 1, left = 0, right = n - 1;
    struct ListNode* current = head;

    while (top <= bottom && left <= right && current != NULL) {
        for (int j = left; j <= right && current != NULL; j++) {
            matrix[top][j] = current->val;
            current = current->next;
        }
        top++;

        for (int i = top; i <= bottom && current != NULL; i++) {
            matrix[i][right] = current->val;
            current = current->next;
        }
        right--;

        if (top <= bottom) {
            for (int j = right; j >= left && current != NULL; j--) {
                matrix[bottom][j] = current->val;
                current = current->next;
            }
            bottom--;
        }

        if (left <= right) {
            for (int i = bottom; i >= top && current != NULL; i--) {
                matrix[i][left] = current->val;
                current = current->next;
            }
            left++;
        }
    }

    *returnSize = m;
    return matrix;
}