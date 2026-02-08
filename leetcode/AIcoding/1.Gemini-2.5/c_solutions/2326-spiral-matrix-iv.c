int** spiralMatrix(int m, int n, struct ListNode* head, int* returnSize, int** returnColumnSizes) {
    int** matrix = (int**)malloc(m * sizeof(int*));
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));

    for (int i = 0; i < m; i++) {
        matrix[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            matrix[i][j] = -1;
        }
    }

    int row_start = 0;
    int row_end = m - 1;
    int col_start = 0;
    int col_end = n - 1;

    while (row_start <= row_end && col_start <= col_end) {
        // Traverse right
        for (int c = col_start; c <= col_end; c++) {
            if (head) {
                matrix[row_start][c] = head->val;
                head = head->next;
            } else {
                goto end_spiral;
            }
        }
        row_start++;

        // Traverse down
        for (int r = row_start; r <= row_end; r++) {
            if (head) {
                matrix[r][col_end] = head->val;
                head = head->next;
            } else {
                goto end_spiral;
            }
        }
        col_end--;

        // Traverse left
        if (row_start <= row_end) {
            for (int c = col_end; c >= col_start; c--) {
                if (head) {
                    matrix[row_end][c] = head->val;
                    head = head->next;
                } else {
                    goto end_spiral;
                }
            }
        }
        row_end--;

        // Traverse up
        if (col_start <= col_end) {
            for (int r = row_end; r >= row_start; r--) {
                if (head) {
                    matrix[r][col_start] = head->val;
                    head = head->next;
                } else {
                    goto end_spiral;
                }
            }
        }
        col_start++;
    }

end_spiral:;

    return matrix;
}