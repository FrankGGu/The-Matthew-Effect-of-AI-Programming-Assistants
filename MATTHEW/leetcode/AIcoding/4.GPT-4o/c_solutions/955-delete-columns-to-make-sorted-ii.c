int minDeletionSize(char** A, int ASize) {
    int n = strlen(A[0]), m = ASize;
    int* deleteColumns = (int*)malloc(n * sizeof(int));
    int count = 0;

    for (int i = 0; i < n; i++) {
        deleteColumns[i] = 1;
    }

    for (int j = 0; j < n; j++) {
        for (int i = 1; i < m; i++) {
            if (deleteColumns[j] && A[i - 1][j] > A[i][j]) {
                deleteColumns[j] = 0;
                count++;
                break;
            }
        }
    }

    free(deleteColumns);
    return count;
}