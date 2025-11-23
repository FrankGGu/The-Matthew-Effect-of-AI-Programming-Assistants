char* maximumBinaryString(char* binary) {
    int n = strlen(binary);
    int zeros = 0;
    int first_zero = -1;

    for (int i = 0; i < n; i++) {
        if (binary[i] == '0') {
            zeros++;
            if (first_zero == -1) {
                first_zero = i;
            }
        }
    }

    if (zeros <= 1) {
        return binary;
    }

    for (int i = 0; i < n; i++) {
        binary[i] = '1';
    }

    binary[first_zero + zeros - 1] = '0';

    return binary;
}