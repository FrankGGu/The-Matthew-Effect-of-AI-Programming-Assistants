int numberOfBeams(char** bank, int bankSize) {
    int total = 0;
    int prev = 0;

    for (int i = 0; i < bankSize; i++) {
        int current = 0;
        for (int j = 0; bank[i][j] != '\0'; j++) {
            if (bank[i][j] == '1') {
                current++;
            }
        }

        if (current > 0) {
            total += prev * current;
            prev = current;
        }
    }

    return total;
}