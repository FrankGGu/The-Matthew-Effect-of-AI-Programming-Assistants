int binaryGap(int n) {
    int last = -1, max_gap = 0, index = 0;

    while (n > 0) {
        if (n & 1) {
            if (last != -1) {
                max_gap = (index - last > max_gap) ? index - last : max_gap;
            }
            last = index;
        }
        index++;
        n >>= 1;
    }

    return max_gap;
}