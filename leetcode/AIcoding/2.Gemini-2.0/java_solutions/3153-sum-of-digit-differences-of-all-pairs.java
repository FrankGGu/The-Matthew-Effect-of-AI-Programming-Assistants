class Solution {
    public int sumDigitDifferences(int[] nums) {
        int n = nums.length;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                sum += digitDifference(nums[i], nums[j]);
            }
        }
        return 2 * sum;
    }

    private int digitDifference(int a, int b) {
        String sa = String.valueOf(a);
        String sb = String.valueOf(b);
        int diff = 0;
        for (int i = 0; i < Math.min(sa.length(), sb.length()); i++) {
            diff += Math.abs(sa.charAt(i) - sb.charAt(i));
        }
        return diff;
    }
}