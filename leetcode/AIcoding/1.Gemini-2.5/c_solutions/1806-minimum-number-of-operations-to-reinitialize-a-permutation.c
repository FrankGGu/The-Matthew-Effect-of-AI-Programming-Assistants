int reinitializePermutation(int n) {
    if (n == 2) {
        return 1;
    }

    int current_pos = 1;
    int operations = 0;

    do {
        if (current_pos < n / 2) {
            current_pos = 2 * current_pos;
        } else {
            current_pos = 2 * current_pos - n + 1;
        }
        operations++;
    } while (current_pos != 1);

    return operations;
}