int subarraysDivByK(int* A, int ASize, int K) {
    int count = 0;
    int* map = (int*)calloc(K, sizeof(int));
    map[0] = 1;
    int sum = 0;

    for (int i = 0; i < ASize; i++) {
        sum += A[i];
        int mod = (sum % K + K) % K;
        count += map[mod];
        map[mod]++;
    }

    free(map);
    return count;
}