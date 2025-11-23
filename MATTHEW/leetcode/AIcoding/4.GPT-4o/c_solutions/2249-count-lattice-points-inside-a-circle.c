int countLatticePoints(int r) {
    int count = 0;
    for (int x = -r; x <= r; x++) {
        for (int y = -r; y <= r; y++) {
            if (x * x + y * y <= r * r) {
                count++;
            }
        }
    }
    return count;
}