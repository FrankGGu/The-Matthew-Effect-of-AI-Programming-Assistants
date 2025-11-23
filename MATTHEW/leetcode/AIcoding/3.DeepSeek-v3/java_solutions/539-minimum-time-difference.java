class Solution {
    public int findMinDifference(List<String> timePoints) {
        boolean[] timeSeen = new boolean[24 * 60];
        for (String time : timePoints) {
            int minutes = Integer.parseInt(time.substring(0, 2)) * 60 + Integer.parseInt(time.substring(3));
            if (timeSeen[minutes]) {
                return 0;
            }
            timeSeen[minutes] = true;
        }

        Integer prev = null;
        int first = Integer.MAX_VALUE;
        int last = Integer.MIN_VALUE;
        int minDiff = Integer.MAX_VALUE;

        for (int i = 0; i < timeSeen.length; i++) {
            if (timeSeen[i]) {
                if (prev != null) {
                    minDiff = Math.min(minDiff, i - prev);
                }
                prev = i;
                first = Math.min(first, i);
                last = Math.max(last, i);
            }
        }

        minDiff = Math.min(minDiff, (24 * 60 - last) + first);
        return minDiff;
    }
}