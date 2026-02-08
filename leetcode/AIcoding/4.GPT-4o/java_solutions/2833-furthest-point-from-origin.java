class Solution {
    public int furthestDistanceFromOrigin(String moves) {
        int left = 0, right = 0, up = 0, down = 0;

        for (char move : moves.toCharArray()) {
            if (move == 'L') left++;
            else if (move == 'R') right++;
            else if (move == 'U') up++;
            else if (move == 'D') down++;
        }

        int horizontal = Math.abs(left - right);
        int vertical = Math.abs(up - down);

        return horizontal + vertical;
    }
}