char findKthBit(int n, int k) {
    if (k == 1) return '0';
    int len = (1 << n) - 1;
    while (n > 1) {
        int mid = (len + 1) / 2;
        if (k == mid) return '1';
        if (k < mid) {
            n--;
        } else {
            k = len - k + 1;
            n--;
        }
        len = mid - 1;
    }
    return '0';
}