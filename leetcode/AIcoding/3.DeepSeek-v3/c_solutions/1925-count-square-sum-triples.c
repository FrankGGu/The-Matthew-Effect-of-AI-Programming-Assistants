int countTriples(int n) {
    int count = 0;
    for (int a = 1; a <= n; a++) {
        for (int b = 1; b <= n; b++) {
            int c_sq = a * a + b * b;
            int c = sqrt(c_sq);
            if (c <= n && c * c == c_sq) {
                count++;
            }
        }
    }
    return count;
}