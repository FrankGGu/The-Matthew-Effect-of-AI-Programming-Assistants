char* findTheWinner(int n, int k) {
    int winner = 0;
    for (int i = 1; i <= n; i++) {
        winner = (winner + k) % i;
    }
    char* result = (char*)malloc(10 * sizeof(char));
    sprintf(result, "%d", winner + 1);
    return result;
}