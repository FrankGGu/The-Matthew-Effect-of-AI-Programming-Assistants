class Solution {
    public boolean isCovered(int[][] ranges, int left, int right) {
        boolean[] covered = new boolean[right - left + 1];
        for (int[] range : ranges) {
            for (int i = Math.max(left, range[0]); i <= Math.min(right, range[1]); i++) {
                covered[i - left] = true;
            }
        }
        for (boolean b : covered) {
            if (!b) {
                return false;
            }
        }
        return true;
    }
}