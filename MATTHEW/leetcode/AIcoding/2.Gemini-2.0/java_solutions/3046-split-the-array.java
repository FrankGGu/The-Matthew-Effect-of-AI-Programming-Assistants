class Solution {
    public boolean splitArray(int[] nums) {
        int n = nums.length;
        if (n < 7) {
            return false;
        }

        int[] sum = new int[n];
        sum[0] = nums[0];
        for (int i = 1; i < n; i++) {
            sum[i] = sum[i - 1] + nums[i];
        }

        for (int j = 3; j < n - 3; j++) {
            for (int i = 1; i < j - 1; i++) {
                if (sum[i - 1] == sum[j - 1] - sum[i]) {
                    for (int k = j + 2; k < n - 1; k++) {
                        if (sum[k - 1] - sum[j] == sum[n - 1] - sum[k] &&
                            sum[i - 1] == sum[k - 1] - sum[j]) {
                            return true;
                        }
                    }
                }
            }
        }

        return false;
    }
}