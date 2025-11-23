int findTheWinner(int n, int k) {
    int winner_0_indexed = 0;
    for (int i = 1; i <= n; i++) {
        winner_0_indexed = (winner_0_indexed + k) % i;
    }
    return winner_0_indexed + 1;
}