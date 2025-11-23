public class Solution {
    public int findMaximumXOR(int[] nums) {
        int max = 0, mask = 0;
        for (int i = 31; i >= 0; i--) {
            mask = mask | (1 << i);
            boolean[] prefix = new boolean[2];
            for (int num : nums) {
                prefix[(num & mask) >> i] = true;
            }
            if (prefix[0] && prefix[1]) {
                max = max | (1 << i);
                mask = mask | (1 << i);
            }
        }
        return max;
    }
}