class Solution {
    public int findValidSplit(int[] nums) {
        int n = nums.length;
        int[] rightMost = new int[51];
        for (int i = 0; i < 51; i++) {
            rightMost[i] = -1;
        }

        for (int i = 0; i < n; i++) {
            int num = nums[i];
            for (int j = 2; j * j <= num; j++) {
                if (num % j == 0) {
                    rightMost[j] = i;
                    while (num % j == 0) {
                        num /= j;
                    }
                }
            }
            if (num > 1) {
                rightMost[num] = i;
            }
        }

        int maxRight = -1;
        for (int i = 0; i < n - 1; i++) {
            int num = nums[i];
            for (int j = 2; j * j <= num; j++) {
                if (num % j == 0) {
                    maxRight = Math.max(maxRight, rightMost[j]);
                    while (num % j == 0) {
                        num /= j;
                    }
                }
            }
            if (num > 1) {
                maxRight = Math.max(maxRight, rightMost[num]);
            }
            if (maxRight <= i) {
                return i;
            }
        }

        return -1;
    }
}