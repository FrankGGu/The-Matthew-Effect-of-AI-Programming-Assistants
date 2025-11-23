class Solution {
    private int maxScore = 0;
    private int[] result = new int[12];

    public int[] maximumBobPoints(int numArrows, int[] aliceArrows) {
        dfs(aliceArrows, numArrows, new int[12], 11, 0);
        return result;
    }

    private void dfs(int[] aliceArrows, int remainingArrows, int[] bobArrows, int currentSection, int currentScore) {
        if (currentSection < 0) {
            if (currentScore > maxScore) {
                maxScore = currentScore;
                result = bobArrows.clone();
                if (remainingArrows > 0) {
                    result[0] += remainingArrows;
                }
            }
            return;
        }

        // Option 1: Do not take the current section
        dfs(aliceArrows, remainingArrows, bobArrows, currentSection - 1, currentScore);

        // Option 2: Take the current section
        int arrowsNeeded = aliceArrows[currentSection] + 1;
        if (remainingArrows >= arrowsNeeded) {
            bobArrows[currentSection] = arrowsNeeded;
            dfs(aliceArrows, remainingArrows - arrowsNeeded, bobArrows, currentSection - 1, currentScore + currentSection);
            bobArrows[currentSection] = 0;
        }
    }
}