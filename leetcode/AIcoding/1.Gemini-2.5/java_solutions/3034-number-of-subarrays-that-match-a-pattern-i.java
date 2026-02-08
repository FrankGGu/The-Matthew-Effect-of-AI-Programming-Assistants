class Solution {
    public int countMatchingSubarrays(int[] nums, int[] pattern) {
        int n = nums.length;
        int m = pattern.length;
        int count = 0;

        for (int i = 0; i <= n - (m + 1); i++) {
            boolean match = true;
            for (int k = 0; k < m; k++) {
                int num1 = nums[i + k];
                int num2 = nums[i + k + 1];
                int pVal = pattern[k];

                if (pVal == 0) {
                    if (num1 != num2) {
                        match = false;
                        break;
                    }
                } else if (pVal == 1) {
                    if (num1 >= num2) {
                        match = false;
                        break;
                    }
                } else if (pVal == -1) {
                    if (num1 <= num2) {
                        match = false;
                        break;
                    }
                }
            }
            if (match) {
                count++;
            }
        }
        return count;
    }
}