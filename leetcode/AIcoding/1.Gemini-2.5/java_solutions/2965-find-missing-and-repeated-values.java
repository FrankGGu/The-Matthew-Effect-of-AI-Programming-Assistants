class Solution {
    public int[] findErrorNums(int[] nums) {
        int n = nums.length;
        long S_expected = (long) n * (n + 1) / 2;
        long S2_expected = (long) n * (n + 1) * (2 * n + 1) / 6;

        long S_actual = 0;
        long S2_actual = 0;

        for (int num : nums) {
            S_actual += num;
            S2_actual += (long) num * num;
        }

        long diff1 = S_actual - S_expected;
        long diff2 = S2_actual - S2_expected;

        long sum_ab = diff2 / diff1;

        int repeated = (int) ((diff1 + sum_ab) / 2);
        int missing = (int) ((sum_ab - diff1) / 2);

        return new int[]{repeated, missing};
    }
}