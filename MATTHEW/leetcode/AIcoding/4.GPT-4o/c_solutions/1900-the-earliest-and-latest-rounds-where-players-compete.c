int earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
    if (firstPlayer > secondPlayer) {
        int temp = firstPlayer;
        firstPlayer = secondPlayer;
        secondPlayer = temp;
    }

    int earliest = 1;
    int latest = 1;

    if (firstPlayer == 1 && secondPlayer == 2) {
        earliest = 1;
        latest = n / 2 + (n % 2 == 1);
    } else {
        earliest = (secondPlayer - firstPlayer == 1) ? 1 : 2;
        latest = n - (secondPlayer - firstPlayer) + 1;
    }

    return earliest * 1000 + latest;
}