int smallestRepunitDivByK(int K) {
    if (K % 2 == 0 || K % 5 == 0) {
        return -1;
    }

    int remainder = 0;
    int length = 0;

    for (int i = 0; i < K; ++i) {
        remainder = (remainder * 10 + 1) % K;
        length++;
        if (remainder == 0) {
            return length;
        }
    }

    return -1;
}