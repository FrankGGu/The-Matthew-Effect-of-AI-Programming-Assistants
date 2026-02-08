int longestString(int x, int y, int z) {
    int mn = x < y ? x : y;
    if (x == y) {
        return (x + y + z) * 2;
    } else {
        return (mn * 2 + 1 + z) * 2;
    }
}