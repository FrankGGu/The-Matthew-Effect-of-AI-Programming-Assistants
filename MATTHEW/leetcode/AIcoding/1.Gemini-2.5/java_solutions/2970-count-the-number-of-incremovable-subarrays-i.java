class Solution {
    public int incremovableSubarrayCount(int[] nums) {
        int n = nums.length;
        int count = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                boolean isIncremovable = true;

                // Check prefix: nums[0...i-1]
                if (i > 0) {
                    for (int k = 0; k < i - 1; k++) {
                        if (nums[k] >= nums[k + 1]) {
                            isIncremovable = false;
                            break;
                        }
                    }
                }
                if (!isIncremovable) {
                    continue;
                }

                // Check suffix: nums[j+1...n-1]
                if (j < n - 1) {
                    for (int k = j + 1; k < n - 1; k++) {
                        if (nums[k] >= nums[k + 1]) {
                            isIncremovable = false;
                            break;
                        }
                    }
                }
                if (!isIncremovable) {
                    continue;
                }

                // Check connection: nums[i-1] < nums[j+1]
                if (i > 0 && j < n - 1) {
                    if (nums[i - 1] >= nums[j + 1]) {
                        isIncremovable = false;
                    }
                }

                if (isIncremovable) {
                    count++;
                }
            }
        }
        return count;
    }
}