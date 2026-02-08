long long maxSquareArea(int n, int m) {
    long long max_h_side = n + 1;
    long long max_v_side = m + 1;

    long long s = (max_h_side < max_v_side) ? max_h_side : max_v_side;

    return s * s;
}