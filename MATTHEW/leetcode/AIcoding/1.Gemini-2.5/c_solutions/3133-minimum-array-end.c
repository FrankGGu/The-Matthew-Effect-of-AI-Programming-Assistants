long long minArrayEnd(int n, int x) {
    long long y = x;
    int n_val = n - 1;
    int bit_pos_y = 0;

    while (n_val > 0) {
        if (!((x >> bit_pos_y) & 1)) {
            if (n_val & 1) {
                y |= (1LL << bit_pos_y);
            }
            n_val >>= 1;
        }
        bit_pos_y++;
    }

    return y;
}