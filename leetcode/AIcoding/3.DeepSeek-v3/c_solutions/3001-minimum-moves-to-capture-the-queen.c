int minMovesToCaptureTheQueen(int a, int b, int c, int d, int e, int f) {
    if (a == e && (c != e || (c == e && (d < b && d < f || d > b && d > f))))
        return 1;
    if (b == f && (d != f || (d == f && (c < a && c < e || c > a && c > e))))
        return 1;
    if (c + d == e + f && (a + b != e + f || (a + b == e + f && (a < c && a < e || a > c && a > e))))
        return 1;
    if (c - d == e - f && (a - b != e - f || (a - b == e - f && (a < c && a < e || a > c && a > e))))
        return 1;
    return 2;
}