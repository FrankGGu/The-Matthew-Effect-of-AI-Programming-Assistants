int minCost(int* A, int ASize, int* B, int BSize) {
    int cost = 0;
    int countA[100001] = {0}, countB[100001] = {0};

    for (int i = 0; i < ASize; i++) {
        countA[A[i]]++;
    }

    for (int i = 0; i < BSize; i++) {
        countB[B[i]]++;
    }

    for (int i = 0; i < 100001; i++) {
        cost += abs(countA[i] - countB[i]);
    }

    return cost / 2;
}