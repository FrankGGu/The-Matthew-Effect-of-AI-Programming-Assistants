int minOperations(int x, int y) {
    int count = 0;
    while (x != y) {
        if (x > y) {
            x /= 10;
        } else {
            y /= 10;
        }
        count++;
    }
    return count;
}