char* findWinningPlayer(int x, int y) {
    if (x == 1) {
        // For x=1, the game state transitions to (0, y-1) or (1, y-2).
        // The pattern observed for (1, y) is:
        // y=1: Alice (T)
        // y=2: Alice (T)
        // y=3: Bob (F)
        // y=4: Bob (F)
        // y=5: Alice (T)
        // y=6: Alice (T)
        // This repeats every 4 values of y.
        // Alice wins if y % 4 == 1 or y % 4 == 2.
        if (y % 4 == 1 || y % 4 == 2) {
            return "Alice";
        } else {
            return "Bob";
        }
    } else { // x >= 2
        // For x >= 2, the game state transitions to (x-1, y-1) or (x, y-2).
        // Since x-1 is still >= 1, the 'x' resource is not depleted to 0 in one move.
        // The pattern observed for (x, y) where x >= 2 is:
        // y=1: Alice (T)
        // y=2: Alice (T)
        // y=3: Bob (F)
        // y=4: Alice (T)
        // y=5: Alice (T)
        // y=6: Bob (F)
        // This repeats every 3 values of y.
        // Alice wins if y % 3 == 1 or y % 3 == 2.
        if (y % 3 == 1 || y % 3 == 2) {
            return "Alice";
        } else {
            return "Bob";
        }
    }
}