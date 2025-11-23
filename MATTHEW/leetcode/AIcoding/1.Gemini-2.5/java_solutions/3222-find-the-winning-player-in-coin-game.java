class Solution {
    public String winningPlayer(int x, int y) {
        // Calculate the maximum number of turns possible in the game.
        // Each move consumes either (1 coin of 100, 1 coin of 75) or (0 coins of 100, 2 coins of 75).
        // Let k be the number of times we make the first type of move.
        // Let m be the number of times we make the second type of move.
        // We need:
        // k <= x (cannot use more 100-coins than available)
        // k + 2m <= y (cannot use more 75-coins than available)
        // We want to maximize the total number of turns, which is k + m.

        // From k + 2m <= y, we get 2m <= y - k, so m <= (y - k) / 2 (integer division).
        // Thus, total turns T = k + m <= k + (y - k) / 2.

        // To maximize T, we need to maximize k + (y - k) / 2.
        // Let's analyze the function f(k) = k + floor((y - k) / 2).
        // If (y - k) is even, f(k) = k + (y - k) / 2 = (2k + y - k) / 2 = (y + k) / 2.
        // If (y - k) is odd, f(k) = k + (y - k - 1) / 2 = (2k + y - k - 1) / 2 = (y + k - 1) / 2.
        // In both cases, f(k) is an increasing function of k.

        // Therefore, to maximize the total turns, we should choose the largest possible k.
        // k is limited by x (k <= x) and also by y (since y - k must be non-negative for m to be valid, so k <= y).
        // Thus, the maximum possible value for k is min(x, y).

        // Let k_max = Math.min(x, y).
        // The maximum number of turns will be k_max + (y - k_max) / 2.

        int k_max = Math.min(x, y);
        int totalTurns = k_max + (y - k_max) / 2;

        // In a normal play impartial game, if the total number of moves is odd, the first player (Alice) wins.
        // If the total number of moves is even, the second player (Bob) wins.
        if (totalTurns % 2 == 1) {
            return "Alice";
        } else {
            return "Bob";
        }
    }
}