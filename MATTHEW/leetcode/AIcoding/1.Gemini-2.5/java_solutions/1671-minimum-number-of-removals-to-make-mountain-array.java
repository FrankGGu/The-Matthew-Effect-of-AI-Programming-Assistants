class Solution {
    public int minimumMountainRemovals(int[] nums) {
        int n = nums.length;

        int[] lis = new int[n];
        for (int i = 0; i < n; i++) {
            lis[i] = 1;
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                    lis[i] = Math.max(lis[i], lis[j] + 1);
                }
            }
        }

        int[] lds = new int[n];
        for (int i = n - 1; i >= 0; i--) {
            lds[i] = 1;
            for (int j = n - 1; j > i; j--) {
                if (nums[i] > nums[j]) {
                    lds[i] = Math.max(lds[i], lds[j] + 1);
                }
            }
        }

        int maxMountainLength = 0;

        for (int i = 0; i < n; i++) {
            if (lis[i] > 1 && lds[i] > 1) {
                maxMountainLength = Math.max(maxMountainLength, lis[i] + lds[i] - 1);
            }
        }

        return n - maxMountainLength;
    }
}