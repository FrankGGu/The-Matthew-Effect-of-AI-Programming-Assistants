int cmp(const void* a, const void* b) {
    int** pa = (int**)a;
    int** pb = (int**)b;
    return (*pa)[1] - (*pb)[1];
}

int findLongestChain(int** pairs, int pairsSize, int* pairsColSize) {
    qsort(pairs, pairsSize, sizeof(int*), cmp);

    int count = 1;
    int end = pairs[0][1];

    for (int i = 1; i < pairsSize; i++) {
        if (pairs[i][0] > end) {
            count++;
            end = pairs[i][1];
        }
    }

    return count;
}