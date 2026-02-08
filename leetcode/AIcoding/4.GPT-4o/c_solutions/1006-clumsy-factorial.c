int clumsy(int N) {
    if (N == 0) return 0;
    if (N == 1) return 1;

    int result = 0;
    int sign = 1; // 1 for positive, -1 for negative

    while (N > 0) {
        if (N >= 4) {
            result += sign * (N * (N - 1) / (N - 2));
            result -= sign * (N - 3);
            N -= 4;
        } else if (N == 3) {
            result += sign * 6; // 3 * 2 / 1
            N -= 3;
        } else if (N == 2) {
            result += sign * 2; // 2 * 1
            N -= 2;
        } else if (N == 1) {
            result += sign * 1;
            N -= 1;
        }
        sign *= -1; // Flip sign for next operation
    }

    return result;
}