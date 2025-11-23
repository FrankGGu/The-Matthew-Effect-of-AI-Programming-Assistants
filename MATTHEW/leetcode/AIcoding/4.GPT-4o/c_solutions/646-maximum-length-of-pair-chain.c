int findLongestChain(int** pairs, int pairsSize, int* pairsColSize) {
    qsort(pairs, pairsSize, sizeof(int*), cmp);
    int count = 0, end = INT_MIN;
    for (int i = 0; i < pairsSize; i++) {
        if (pairs[i][0] > end) {
            count++;
            end = pairs[i][1];
        }
    }
    return count;
}

int cmp(const void *a, const void *b) {
    return (*(int**)a)[1] - (*(int**)b)[1];
}