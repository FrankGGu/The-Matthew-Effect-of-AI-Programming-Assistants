public class Solution {
    public int maxNumberOfAlloys(int n, int k, int[] target, int[] efficiency, long[] maxRes) {
        int max = 0;
        for (int i = 0; i < n; i++) {
            int count = 0;
            long total = 0;
            for (int j = 0; j < k; j++) {
                if (efficiency[j] == 0) continue;
                long temp = maxRes[j] / efficiency[j];
                if (temp > 0) {
                    count += temp;
                    total += temp * efficiency[j];
                }
            }
            max = Math.max(max, count);
        }
        return max;
    }
}