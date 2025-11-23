class Solution {
    public boolean canBeIncreasing(int[] nums) {
        int n = nums.length;
        int violationCount = 0;
        int violationIndex = -1;

        for (int i = 0; i < n - 1; i++) {
            if (nums[i] >= nums[i + 1]) {
                violationCount++;
                violationIndex = i;
            }
        }

        if (violationCount == 0) {
            return true;
        }

        if (violationCount > 1) {
            return false;
        }

        // Exactly one violation found at violationIndex
        // Try removing nums[violationIndex]
        int[] temp1 = new int[n - 1];
        int k = 0;
        for (int i = 0; i < n; i++) {
            if (i != violationIndex) {
                temp1[k++] = nums[i];
            }
        }
        if (isStrictlyIncreasing(temp1)) {
            return true;
        }

        // Try removing nums[violationIndex + 1]
        int[] temp2 = new int[n - 1];
        k = 0;
        for (int i = 0; i < n; i++) {
            if (i != violationIndex + 1) {
                temp2[k++] = nums[i];
            }
        }
        if (isStrictlyIncreasing(temp2)) {
            return true;
        }

        return false;
    }

    private boolean isStrictlyIncreasing(int[] arr) {
        for (int i = 0; i < arr.length - 1; i++) {
            if (arr[i] >= arr[i + 1]) {
                return false;
            }
        }
        return true;
    }
}