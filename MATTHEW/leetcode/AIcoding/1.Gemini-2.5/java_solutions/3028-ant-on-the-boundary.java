class Solution {
    public int returnToBoundaryCount(int[] moves) {
        int currentPosition = 0;
        int count = 0;
        for (int move : moves) {
            currentPosition += move;
            if (currentPosition == 0) {
                count++;
            }
        }
        return count;
    }
}