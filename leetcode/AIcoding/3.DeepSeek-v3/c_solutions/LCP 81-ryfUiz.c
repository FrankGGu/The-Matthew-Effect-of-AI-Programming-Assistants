int getNandResult(int k, int* arr, int arrSize, int** operations, int operationsSize, int* operationsColSize) {
    int result = 0;
    int mask = (1 << k) - 1;

    for (int i = 0; i < operationsSize; i++) {
        int type = operations[i][0];
        int x = operations[i][1];
        int y = operations[i][2];

        if (type == 0) {
            arr[x] = y & mask;
        } else {
            int temp = arr[x];
            for (int j = x + 1; j <= y; j++) {
                temp = (~(temp & arr[j])) & mask;
            }
            result ^= temp;
        }
    }

    return result;
}