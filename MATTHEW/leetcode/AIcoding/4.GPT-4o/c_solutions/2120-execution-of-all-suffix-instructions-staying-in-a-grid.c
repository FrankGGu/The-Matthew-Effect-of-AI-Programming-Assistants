int executeInstructions(int n, int startRow, int startCol, int* s, int sSize, int* returnSize) {
    int* result = (int*)malloc(sSize * sizeof(int));
    *returnSize = sSize;
    for (int i = 0; i < sSize; i++) {
        int row = startRow, col = startCol, count = 0;
        for (int j = i; j < sSize; j++) {
            if (s[j] == 'L') col--;
            else if (s[j] == 'R') col++;
            else if (s[j] == 'U') row--;
            else if (s[j] == 'D') row++;
            if (row < 0 || row >= n || col < 0 || col >= n) break;
            count++;
        }
        result[i] = count;
    }
    return result;
}