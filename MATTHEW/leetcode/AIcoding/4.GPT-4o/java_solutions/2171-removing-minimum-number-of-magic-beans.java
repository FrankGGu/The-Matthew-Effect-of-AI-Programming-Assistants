import java.util.Arrays;

class Solution {
    public long minimumRemoval(int[] beans) {
        Arrays.sort(beans);
        long totalBeans = 0;
        for (int bean : beans) {
            totalBeans += bean;
        }
        long minRemoval = Long.MAX_VALUE;
        long currentRemoval = 0;

        for (int i = 0; i < beans.length; i++) {
            currentRemoval += beans[i];
            long remainingBeans = totalBeans - currentRemoval;
            long count = (long) beans[i] * (beans.length - i - 1);
            minRemoval = Math.min(minRemoval, remainingBeans - count);
        }

        return minRemoval;
    }
}