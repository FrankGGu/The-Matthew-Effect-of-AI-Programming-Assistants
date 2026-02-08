import java.util.Arrays;

class Solution {
    public long minimumRemoval(int[] beans) {
        Arrays.sort(beans);
        long sum = 0;
        for (int bean : beans) {
            sum += bean;
        }
        long min = Long.MAX_VALUE;
        for (int i = 0; i < beans.length; i++) {
            min = Math.min(min, sum - (long)beans[i] * (beans.length - i));
        }
        return min;
    }
}