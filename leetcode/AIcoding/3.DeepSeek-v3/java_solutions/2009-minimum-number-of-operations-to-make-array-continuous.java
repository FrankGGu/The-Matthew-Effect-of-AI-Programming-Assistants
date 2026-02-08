class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        if (n == 0) return 0;

        Arrays.sort(nums);

        int uniqueLen = 1;
        for (int i = 1; i < n; i++) {
            if (nums[i] != nums[i - 1]) {
                nums[uniqueLen++] = nums[i];
            }
        }

        int minOps = n;
        for (int i = 0, j = 0; i < uniqueLen; i++) {
            while (j < uniqueLen && nums[j] - nums[i] <= n - 1) {
                j++;
            }
            minOps = Math.min(minOps, n - (j - i));
        }

        return minOps;
    }
}