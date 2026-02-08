int numberOfArrays(int* differences, int differencesSize, int lower, int upper) {
    long long min_val = 0, max_val = 0;
    long long current = 0;

    for (int i = 0; i < differencesSize; i++) {
        current += differences[i];
        if (current < min_val) min_val = current;
        if (current > max_val) max_val = current;
    }

    long long range = (max_val - min_val);
    long long total_range = (upper - lower);

    if (total_range < range) {
        return 0;
    }

    return (total_range - range);
}