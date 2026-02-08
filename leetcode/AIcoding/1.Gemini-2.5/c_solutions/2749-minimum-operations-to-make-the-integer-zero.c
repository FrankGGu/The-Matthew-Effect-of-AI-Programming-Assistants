long long minimumOperations(int num, int p) {
    for (int i = 1; i <= 65; ++i) {
        long long current_num_val = (long long)num - (long long)i * p;

        if (current_num_val < i) {
            continue;
        }

        if (__builtin_popcountll(current_num_val) <= i) {
            return i;
        }
    }

    return -1; 
}