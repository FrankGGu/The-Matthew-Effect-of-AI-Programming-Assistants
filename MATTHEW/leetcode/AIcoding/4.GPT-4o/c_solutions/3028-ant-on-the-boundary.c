int antOnBoundary(int A, int B, int C, int D) {
    if (C == 0) return (D % 2 == 0) ? 0 : B;
    if (C == A) return (D % 2 == 0) ? B : 0;
    if (D % 2 == 0) {
        if (C < A) return C + D % (2 * A);
        return 2 * A - C + D % (2 * A);
    } else {
        if (C < A) return A - C + D % (2 * B);
        return C - (2 * B - D % (2 * B));
    }
}