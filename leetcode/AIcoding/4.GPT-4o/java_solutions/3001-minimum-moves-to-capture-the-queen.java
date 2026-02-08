class Solution {
    public int minQueenMoves(String queen, String king) {
        int qX = queen.charAt(0) - 'a';
        int qY = queen.charAt(1) - '1';
        int kX = king.charAt(0) - 'a';
        int kY = king.charAt(1) - '1';

        return Math.max(Math.abs(qX - kX), Math.abs(qY - kY));
    }
}