public class Solution {
    public int countRangeSum(int[] nums, int[] operation) {
        int n = nums.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int count = 0;
        for (int i = 0; i < operation.length; i++) {
            int l = operation[i];
            int r = operation[i + 1];
            i++;
            for (int j = l; j <= r; j++) {
                for (int k = j + 1; k <= n; k++) {
                    if (prefix[k] - prefix[j] >= 0 && prefix[k] - prefix[j] <= 1000000) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}