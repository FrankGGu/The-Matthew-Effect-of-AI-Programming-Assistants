public class Solution {
    public int maxExcellentPairs(int[] nums, int k) {
        int[] count = new int[32];
        for (int num : nums) {
            int bits = 0;
            for (int i = 0; i < 32; i++) {
                if ((num & (1 << i)) != 0) {
                    bits++;
                }
            }
            count[bits]++;
        }

        int result = 0;
        for (int i = 0; i <= 31; i++) {
            for (int j = 0; j <= 31; j++) {
                if (i + j >= k) {
                    result += count[i] * count[j];
                }
            }
        }
        return result;
    }
}