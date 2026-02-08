int numberOfArrays(int* differences, int differencesSize, int lower, int upper, int k) {
    if (k == 0) return 0;

    long long min_val = 0, max_val = 0;
    long long current = 0;

    for (int i = 0; i < differencesSize; i++) {
        current += differences[i];
        if (current < min_val) min_val = current;
        if (current > max_val) max_val = current;
    }

    long long range = max_val - min_val;
    long long available = (upper - lower) - range;

    if (available < 0) return 0;

    long long result = (available + 1) * k % 1000000007;
    return (int)result;
}