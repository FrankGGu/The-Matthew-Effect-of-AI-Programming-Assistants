bool canArrange(int* arr, int arrSize, int k) {
    int count[k];
    memset(count, 0, sizeof(count));

    for (int i = 0; i < arrSize; i++) {
        int mod = ((arr[i] % k) + k) % k;
        count[mod]++;
    }

    for (int i = 1; i < k; i++) {
        if (count[i] != count[k - i]) {
            return false;
        }
    }

    return count[0] % 2 == 0;
}