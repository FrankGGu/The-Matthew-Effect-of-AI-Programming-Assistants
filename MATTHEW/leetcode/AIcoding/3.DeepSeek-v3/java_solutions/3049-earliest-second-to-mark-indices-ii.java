class Solution {
    public int earliestSecondToMarkIndices(int[] nums, int[] changeIndices) {
        int n = nums.length;
        int m = changeIndices.length;
        int left = 0, right = m;
        int ans = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canMarkAll(nums, changeIndices, mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }

    private boolean canMarkAll(int[] nums, int[] changeIndices, int s) {
        int n = nums.length;
        int m = changeIndices.length;
        int[] lastOccurrence = new int[n + 1];
        Arrays.fill(lastOccurrence, -1);
        for (int i = 0; i < s; i++) {
            int idx = changeIndices[i];
            lastOccurrence[idx] = i;
        }
        for (int i = 1; i <= n; i++) {
            if (lastOccurrence[i] == -1) {
                return false;
            }
        }
        int operations = 0;
        for (int i = 0; i < s; i++) {
            int idx = changeIndices[i];
            if (i == lastOccurrence[idx]) {
                if (operations < nums[idx - 1]) {
                    return false;
                }
                operations -= nums[idx - 1];
            } else {
                operations++;
            }
        }
        return true;
    }
}