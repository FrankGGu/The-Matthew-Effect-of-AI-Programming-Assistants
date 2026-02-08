class Solution {
    public int minImpossibleOR(int[] nums) {
        boolean[] seen = new boolean[32];
        for (int num : nums) {
            if ((num & (num - 1)) == 0) {
                int powerOfTwo = 0;
                while ((1 << powerOfTwo) != num) {
                    powerOfTwo++;
                }
                seen[powerOfTwo] = true;
            }
        }

        for (int i = 0; i < 32; i++) {
            if (!seen[i]) {
                return 1 << i;
            }
        }

        return -1;
    }
}