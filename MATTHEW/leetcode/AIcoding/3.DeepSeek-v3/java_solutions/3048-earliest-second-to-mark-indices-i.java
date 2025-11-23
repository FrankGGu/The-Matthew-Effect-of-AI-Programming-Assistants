class Solution {
    public int earliestSecondToMarkIndices(int[] nums, int[] changeIndices) {
        int n = nums.length;
        int m = changeIndices.length;
        int left = 0, right = m;
        int result = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canMarkAll(nums, changeIndices, mid)) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }

    private boolean canMarkAll(int[] nums, int[] changeIndices, int s) {
        int n = nums.length;
        int m = changeIndices.length;
        int[] lastOccurrence = new int[n + 1];
        Arrays.fill(lastOccurrence, -1);

        for (int i = 0; i < s; i++) {
            int idx = changeIndices[i] - 1;
            if (idx >= 0 && idx < n) {
                lastOccurrence[idx] = i;
            }
        }

        for (int i = 0; i < n; i++) {
            if (lastOccurrence[i] == -1) {
                return false;
            }
        }

        int operations = 0;
        for (int i = 0; i < s; i++) {
            int idx = changeIndices[i] - 1;
            if (idx >= 0 && idx < n && lastOccurrence[idx] == i) {
                if (operations < nums[idx]) {
                    return false;
                }
                operations -= nums[idx];
            } else {
                operations++;
            }
        }

        return true;
    }
}