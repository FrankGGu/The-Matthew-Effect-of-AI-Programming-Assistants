int relicTransmission(int n, int* parent, int parentSize, int* val, int valSize, int u, int v) {
    int min_val = val[0];
    for (int i = 1; i < n; ++i) {
        if (val[i] < min_val) {
            min_val = val[i];
        }
    }
    return min_val;
}