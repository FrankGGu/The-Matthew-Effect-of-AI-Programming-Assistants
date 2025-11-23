class Solution {
    public int[] findErrorNums(int[] nums) {
        int[] result = new int[2];
        int n = nums.length;
        boolean[] seen = new boolean[n + 1];

        for (int num : nums) {
            if (seen[num]) {
                result[0] = num;
            }
            seen[num] = true;
        }

        for (int i = 1; i <= n; i++) {
            if (!seen[i]) {
                result[1] = i;
                break;
            }
        }

        return result;
    }
}