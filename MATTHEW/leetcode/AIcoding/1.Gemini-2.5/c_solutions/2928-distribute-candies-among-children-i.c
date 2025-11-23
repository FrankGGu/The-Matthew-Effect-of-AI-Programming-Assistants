int distributeCandies(int n, int limit) {
    int count = 0;
    for (int c1 = 0; c1 <= limit; c1++) {
        for (int c2 = 0; c2 <= limit; c2++) {
            int c3 = n - c1 - c2;
            if (c3 >= 0 && c3 <= limit) {
                count++;
            }
        }
    }
    return count;
}