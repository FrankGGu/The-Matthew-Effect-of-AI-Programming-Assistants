class Solution {
    public int[] maximumBobPoints(int numArrows, int[] aliceArrows) {
        // dp[i][j] represents the maximum score Bob can achieve considering
        // score regions from 'i' to 11 (inclusive), using 'j' arrows.
        // The regions are 0-indexed, so region 'i' gives 'i' points.
        // We will build this DP table from region 11 down to 0.
        // The size of aliceArrows is 12, so regions are 0 to 11.

        // dp table size: 13 rows (for regions 0 to 12) and numArrows + 1 columns (for 0 to numArrows arrows).
        // dp[12][j] will be the base case (0 score for no regions left), initialized to 0 by default.
        int[][] dp = new int[13][numArrows + 1];

        // Fill the DP table for regions from 11 down to 0.
        // Region 0 gives 0 points. Bob should never spend arrows to win it unless those are leftover arrows.
        // So, we only consider winning regions 1 through 11 for positive points.
        for (int region = 11; region >= 0; region--) { // Iterate regions from 11 down to 0
            int arrowsNeededToWin = aliceArrows[region] + 1;
            for (int j = 0; j <= numArrows; j++) { // Iterate available arrows
                // Option 1: Bob does not try to win current 'region'.
                // Score is whatever he gets from regions 'region+1' to 11 using 'j' arrows.
                dp[region][j] = dp[region + 1][j];

                // Option 2: Bob tries to win current 'region'.
                // This is only considered if 'region' gives points (i.e., region > 0)
                // and he has enough arrows.
                if (region > 0 && j >= arrowsNeededToWin) {
                    // Score is 'region' points + score from regions 'region+1' to 11
                    // using 'j - arrowsNeededToWin' arrows.
                    dp[region][j] = Math.max(dp[region][j], region + dp[region + 1][j - arrowsNeededToWin]);
                }
            }
        }

        // Find the maximum score Bob can achieve and the corresponding number of arrows used.
        // The maximum score will be found in dp[0][j] for some j <= numArrows.
        // dp[0][j] represents the max score from regions 0 to 11 using j arrows.
        // Since region 0 gives 0 points, dp[0][j] effectively represents the max score
        // from regions 1 to 11 using j arrows (as per our DP logic for region 0).
        int maxScore = 0;
        int bestArrowsUsed = 0; // The number of arrows Bob actually used to win points (regions 1-11).

        for (int j = 0; j <= numArrows; j++) {
            if (dp[0][j] > maxScore) {
                maxScore = dp[0][j];
                bestArrowsUsed = j;
            }
        }

        // Reconstruct Bob's arrow distribution
        int[] bobArrows = new int[12];
        int currentArrows = bestArrowsUsed; // Arrows available for reconstruction from bestArrowsUsed

        // Iterate from region 11 down to 1 to reconstruct the choices
        for (int region = 11; region >= 1; region--) { // Only regions 1 to 11 contribute points
            int arrowsNeededToWin = aliceArrows[region] + 1;

            // Check if Bob chose to win this 'region'.
            // This is true if currentArrows is sufficient AND
            // winning this region (region points + score from next regions with fewer arrows)
            // resulted in the maximum score for dp[region][currentArrows].
            int scoreIfWon = region + dp[region + 1][currentArrows - arrowsNeededToWin];

            if (currentArrows >= arrowsNeededToWin && dp[region][currentArrows] == scoreIfWon) {
                bobArrows[region] = arrowsNeededToWin;
                currentArrows -= arrowsNeededToWin;
            } else {
                bobArrows[region] = 0; // Bob did not win this region
            }
        }

        // All remaining arrows must be placed in region 0 to satisfy numArrows total.
        // 'currentArrows' at this point holds the number of arrows *from bestArrowsUsed* that were NOT spent on regions 1-11.
        // 'numArrows - bestArrowsUsed' is the number of arrows that Bob *did not even try to spend to win points*.
        // Both these quantities must be added to bobArrows[0].
        bobArrows[0] = currentArrows + (numArrows - bestArrowsUsed);

        return bobArrows;
    }
}