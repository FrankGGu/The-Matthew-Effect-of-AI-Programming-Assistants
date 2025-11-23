int hIndex(int* citations, int citationsSize) {
    int left = 0, right = citationsSize, mid;

    while (left < right) {
        mid = left + (right - left) / 2;
        if (citations[citationsSize - mid - 1] >= mid + 1) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}