int getWinner(int* arr, int arrSize, int k) {
    int current_winner_val = arr[0];
    int consecutive_wins = 0;

    for (int i = 1; i < arrSize; i++) {
        int opponent_val = arr[i];
        if (current_winner_val > opponent_val) {
            consecutive_wins++;
        } else {
            current_winner_val = opponent_val;
            consecutive_wins = 1;
        }

        if (consecutive_wins == k) {
            return current_winner_val;
        }
    }

    // If the loop finishes, it means the current_winner_val has defeated all other
    // players that were initially in the array after it. This player is
    // effectively the strongest and will continue to win indefinitely.
    // Thus, it will eventually achieve k wins, regardless of the current
    // consecutive_wins count.
    return current_winner_val;
}