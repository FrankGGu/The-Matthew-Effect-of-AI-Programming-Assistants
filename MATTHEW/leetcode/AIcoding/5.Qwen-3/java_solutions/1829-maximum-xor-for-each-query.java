public class Solution {
    public int[] maximizeXor(int[] queries, int[] nums) {
        int n = queries.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            int max = 0;
            for (int num : nums) {
                max = Math.max(max, queries[i] ^ num);
            }
            result[i] = max;
        }
        return result;
    }
}