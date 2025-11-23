class Solution {
    public int iceBreakingGame(int numIce, int rounds) {
        if (rounds >= numIce) {
            return 0;
        }
        return numIce % (rounds + 1) == 0 ? rounds : numIce % (rounds + 1) - 1;
    }
}