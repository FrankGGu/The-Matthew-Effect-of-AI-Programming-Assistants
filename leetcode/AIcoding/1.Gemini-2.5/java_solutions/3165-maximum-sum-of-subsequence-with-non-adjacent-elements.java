class Solution {
    public int rob(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        int include = 0;
        int exclude = 0;

        for (int num : nums) {
            int newInclude = exclude + num;
            int newExclude = Math.max(include, exclude);

            include = newInclude;
            exclude = newExclude;
        }

        return Math.max(include, exclude);
    }
}