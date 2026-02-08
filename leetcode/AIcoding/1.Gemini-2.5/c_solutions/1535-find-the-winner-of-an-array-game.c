int getWinner(int* arr, int arrSize, int k) {
    int current_winner = arr[0];
    int consecutive_wins = 0;

    for (int i = 1; i < arrSize; i++) {
        int opponent = arr[i];
        if (current_winner > opponent) {
            consecutive_wins++;
        } else {
            current_winner = opponent;
            consecutive_wins = 1;
        }

        if (consecutive_wins == k) {
            return current_winner;
        }
    }

    return current_winner;
}