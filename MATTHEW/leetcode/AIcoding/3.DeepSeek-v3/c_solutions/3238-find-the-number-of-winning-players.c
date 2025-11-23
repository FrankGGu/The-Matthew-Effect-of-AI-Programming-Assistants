int winningPlayerCount(int n, int** pick) {
    int* freq = (int*)calloc(11, sizeof(int));
    int winners = 0;

    for (int i = 0; i < n; i++) {
        int x = pick[i][0];
        int y = pick[i][1];
        freq[x]++;
        if (freq[x] == x) {
            winners++;
        } else if (freq[x] > x && freq[x] - 1 == x) {
            winners--;
        }
    }

    free(freq);
    return winners;
}