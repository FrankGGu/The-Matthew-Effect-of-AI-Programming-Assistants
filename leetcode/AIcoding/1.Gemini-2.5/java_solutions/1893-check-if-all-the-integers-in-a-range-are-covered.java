class Solution {
    public boolean isCovered(int[][] ranges, int left, int right) {
        boolean[] covered = new boolean[51]; // Max value is 50, so index 50 is needed.

        for (int[] range : ranges) {
            int start = range[0];
            int end = range[1];
            for (int i = start; i <= end; i++) {
                covered[i] = true;
            }
        }

        for (int i = left; i <= right; i++) {
            if (!covered[i]) {
                return false;
            }
        }

        return true;
    }
}