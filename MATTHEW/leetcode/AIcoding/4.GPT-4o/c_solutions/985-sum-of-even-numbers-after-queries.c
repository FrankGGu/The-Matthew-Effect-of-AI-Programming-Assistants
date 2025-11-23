int* sumEvenAfterQueries(int* A, int ASize, int** queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * queriesSize);
    int sumEven = 0;

    for (int i = 0; i < ASize; i++) {
        if (A[i] % 2 == 0) {
            sumEven += A[i];
        }
    }

    for (int i = 0; i < queriesSize; i++) {
        int val = queries[i][0];
        int index = queries[i][1];

        if (A[index] % 2 == 0) {
            sumEven -= A[index];
        }

        A[index] += val;

        if (A[index] % 2 == 0) {
            sumEven += A[index];
        }

        result[i] = sumEven;
    }

    *returnSize = queriesSize;
    return result;
}