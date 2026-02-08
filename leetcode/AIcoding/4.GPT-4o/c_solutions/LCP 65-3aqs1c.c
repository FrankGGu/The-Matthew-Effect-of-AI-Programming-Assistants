int comfortableNumbers(int L, int R) {
    int count = 0;
    for (int a = L; a <= R; a++) {
        for (int b = L; b <= R; b++) {
            if (a != b) {
                int aLow = a - 10, aHigh = a + 10;
                if (b >= aLow && b <= aHigh) {
                    count++;
                }
            }
        }
    }
    return count / 2;
}