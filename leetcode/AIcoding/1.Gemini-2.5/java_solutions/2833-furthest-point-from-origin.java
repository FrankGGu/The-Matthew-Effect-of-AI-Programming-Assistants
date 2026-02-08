class Solution {
    public int furthestDistanceFromOrigin(String moves) {
        int countL = 0;
        int countR = 0;
        int countUnderscore = 0;

        for (char move : moves.toCharArray()) {
            if (move == 'L') {
                countL++;
            } else if (move == 'R') {
                countR++;
            } else {
                countUnderscore++;
            }
        }

        return Math.abs(countR - countL) + countUnderscore;
    }
}