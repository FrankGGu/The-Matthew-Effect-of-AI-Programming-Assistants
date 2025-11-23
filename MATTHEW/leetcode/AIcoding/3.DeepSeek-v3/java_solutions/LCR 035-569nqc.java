class Solution {
    public int findMinDifference(List<String> timePoints) {
        boolean[] mark = new boolean[24 * 60];
        for (String time : timePoints) {
            String[] t = time.split(":");
            int h = Integer.parseInt(t[0]);
            int m = Integer.parseInt(t[1]);
            int total = h * 60 + m;
            if (mark[total]) {
                return 0;
            }
            mark[total] = true;
        }

        int prev = -1, first = -1, minDiff = Integer.MAX_VALUE;
        for (int i = 0; i < 24 * 60; i++) {
            if (mark[i]) {
                if (prev != -1) {
                    minDiff = Math.min(minDiff, i - prev);
                } else {
                    first = i;
                }
                prev = i;
            }
        }
        minDiff = Math.min(minDiff, (24 * 60 - prev + first));
        return minDiff;
    }
}