int minChanges(int n, int k) {
    int changes = 0;
    for (int i = 0; i < 31; i++) {
        int n_bit = (n >> i) & 1;
        int k_bit = (k >> i) & 1;

        if (n_bit == 1 && k_bit == 0) {
            changes++;
        } else if (n_bit == 0 && k_bit == 1) {
            return -1;
        }
    }
    return changes;
}