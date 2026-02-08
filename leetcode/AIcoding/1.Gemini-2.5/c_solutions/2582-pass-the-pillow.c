int passThePillow(int n, int time) {
    int cycle_len = 2 * (n - 1);
    if (cycle_len == 0) {
        return 1;
    }
    int effective_time = time % cycle_len;

    if (effective_time < n) {
        return effective_time + 1;
    } else {
        return n - (effective_time - (n - 1));
    }
}