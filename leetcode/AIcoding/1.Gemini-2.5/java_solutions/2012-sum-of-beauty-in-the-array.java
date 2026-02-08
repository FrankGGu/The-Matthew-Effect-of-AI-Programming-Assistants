class Solution {
    public int sumOfBeauties(int[] nums) {
        int n = nums.length;
        if (n < 3) {
            return 0;
        }

        int[] prefixMax = new int[n];
        int[] suffixMin = new int[n];

        prefixMax[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefixMax[i] = Math.max(prefixMax[i - 1], nums[i]);
        }

        suffixMin[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            suffixMin[i] = Math.min(suffixMin[i + 1], nums[i]);
        }

        int totalBeauty = 0;

        for (int i = 1; i <= n - 2; i++) {
            if (nums[i] > prefixMax[i - 1] && nums[i] < suffixMin[i + 1]) {
                totalBeauty += 2;
            } else if (nums[i - 1] < nums[i] && nums[i] < nums[i + 1]) {
                totalBeauty += 1;
            }
        }

        return totalBeauty;
    }
}