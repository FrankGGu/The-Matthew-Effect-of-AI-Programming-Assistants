class Solution {
    private static final int MAX_VAL = Integer.MAX_VALUE / 2; // Use /2 to prevent overflow on addition

    // Helper to convert char to (row, col) coordinates on a 6x5 keyboard
    // A-E (0,0)-(0,4)
    // F-J (1,0)-(1,4)
    // K-O (2,0)-(2,4)
    // P-T (3,0)-(3,4)
    // U-Y (4,0)-(4,4)
    // Z   (5,0)
    private int[] getCoords(char c) {
        int charIdx = c - 'A';
        return new int[]{charIdx / 5, charIdx % 5};
    }

    // Helper to calculate Manhattan distance between two characters
    private int getDistance(char c1, char c2) {
        int[] p1 = getCoords(c1);
        int[] p2 = getCoords(c2);
        return Math.abs(p1[0] - p2[0]) + Math.abs(p1[1] - p2[1]);
    }

    public int minimumDistance(String word) {
        int N = word.length();

        // dp[k][f1_mapped][f2_mapped]
        // k: index of the character to type next (word[k])
        // f1_mapped: (index of char under finger 1) + 1.
        //            0 means imaginary initial position.
        //            1 to N means word[0] to word[N-1].
        // f2_mapped: (index of char under finger 2) + 1.
        //            0 means imaginary initial position.
        //            1 to N means word[0] to word[N-1].
        int[][][] dp = new int[N + 1][N + 1][N + 1];

        // Initialize with a large value (infinity)
        for (int i = 0; i <= N; i++) {
            for (int j = 0; j <= N; j++) {
                for (int l = 0; l <= N; l++) {
                    dp[i][j][l] = MAX_VAL;
                }
            }
        }

        // Base case: 0 distance to type 0 characters, both fingers imaginary
        dp[0][0][0] = 0; 

        // Iterate through each character to be typed
        for (int k = 0; k < N; k++) { // k is the index of the character we are about to type
            char targetChar = word.charAt(k);

            // Iterate through all possible positions of finger 1 *before* typing word[k]
            // f1_mapped can be 0 (imaginary) or 1 to k (word[0] to word[k-1])
            for (int f1_mapped = 0; f1_mapped <= k; f1_mapped++) {
                // Iterate through all possible positions of finger 2 *before* typing word[k]
                // f2_mapped can be 0 (imaginary) or 1 to k (word[0] to word[k-1])
                for (int f2_mapped = 0; f2_mapped <= k; f2_mapped++) {

                    if (dp[k][f1_mapped][f2_mapped] == MAX_VAL) {
                        continue; // This state is unreachable
                    }

                    int currentDist = dp[k][f1_mapped][f2_mapped];

                    // Option 1: Use finger 1 to type word[k]
                    int cost1;
                    if (f1_mapped == 0) { // Finger 1 is at imaginary position
                        cost1 = 0;
                    } else { // Finger 1 is on word.charAt(f1_mapped - 1)
                        char f1_char = word.charAt(f1_mapped - 1);
                        cost1 = getDistance(f1_char, targetChar);
                    }
                    // Update dp[k+1] state: finger 1 moves to word[k], finger 2 stays at f2_mapped
                    dp[k + 1][k + 1][f2_mapped] = Math.min(dp[k + 1][k + 1][f2_mapped], currentDist + cost1);

                    // Option 2: Use finger 2 to type word[k]
                    int cost2;
                    if (f2_mapped == 0) { // Finger 2 is at imaginary position
                        cost2 = 0;
                    } else { // Finger 2 is on word.charAt(f2_mapped - 1)
                        char f2_char = word.charAt(f2_mapped - 1);
                        cost2 = getDistance(f2_char, targetChar);
                    }
                    // Update dp[k+1] state: finger 2 moves to word[k], finger 1 stays at f1_mapped
                    dp[k + 1][f1_mapped][k + 1] = Math.min(dp[k + 1][f1_mapped][k + 1], currentDist + cost2);
                }
            }
        }

        // The answer is the minimum value in dp[N][any_f1_mapped][any_f2_mapped]
        // after typing all N characters, one finger will be on word[N-1] (mapped to N),
        // the other finger could be on any word[0] to word[N-2] (mapped to 1 to N-1) or still imaginary (mapped to 0).
        int minTotalDistance = MAX_VAL;
        for (int f1_mapped = 0; f1_mapped <= N; f1_mapped++) {
            for (int f2_mapped = 0; f2_mapped <= N; f2_mapped++) {
                minTotalDistance = Math.min(minTotalDistance, dp[N][f1_mapped][f2_mapped]);
            }
        }

        return minTotalDistance;
    }
}