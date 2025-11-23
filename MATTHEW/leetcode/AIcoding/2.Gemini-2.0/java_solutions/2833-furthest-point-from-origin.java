class Solution {
    public int furthestDistanceFromOrigin(String moves) {
        int l = 0, r = 0, underscore = 0;
        for (char c : moves.toCharArray()) {
            if (c == 'L') {
                l++;
            } else if (c == 'R') {
                r++;
            } else {
                underscore++;
            }
        }
        return Math.abs(l - r) + underscore;
    }
}