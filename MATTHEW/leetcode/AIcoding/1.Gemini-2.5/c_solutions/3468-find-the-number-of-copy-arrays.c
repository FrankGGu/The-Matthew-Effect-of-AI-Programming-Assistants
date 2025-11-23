int findNumberOfCopyArrays(int* a, int n) {
    long long N_oe = 0; // count of a[i] is odd and i is even
    long long N_eo = 0; // count of a[i] is even and i is odd

    for (int i = 0; i < n; i++) {
        int val_parity = a[i] % 2;
        int idx_parity = i % 2;

        if (val_parity == 1 && idx_parity == 0) { // a[i] is odd, i is even
            N_oe++;
        } else if (val_parity == 0 && idx_parity == 1) { // a[i] is even, i is odd
            N_eo++;
        }
    }

    if (N_oe == 0 && N_eo == 0) {
        return 1;
    } else {
        return 0;
    }
}