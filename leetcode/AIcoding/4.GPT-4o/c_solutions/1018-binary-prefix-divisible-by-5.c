bool* prefixesDivBy5(int* A, int ASize, int* returnSize) {
    bool* result = (bool*)malloc(ASize * sizeof(bool));
    *returnSize = ASize;
    int current = 0;

    for (int i = 0; i < ASize; i++) {
        current = (current << 1) + A[i];
        result[i] = (current % 5 == 0);
    }

    return result;
}