class Solution {
    public int earliestSecondToMarkIndices(int[] nums, int[] changeIndices) {
        int n = nums.length;
        int m = changeIndices.length;
        int left = 1, right = m;
        int ans = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(nums, changeIndices, mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }

    private boolean check(int[] nums, int[] changeIndices, int k) {
        int n = nums.length;
        int[] lastOccurrence = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            lastOccurrence[i] = -1;
        }

        for (int i = 0; i < k; i++) {
            lastOccurrence[changeIndices[i]] = i;
        }

        for (int i = 1; i <= n; i++) {
            if (lastOccurrence[i] == -1) {
                return false;
            }
        }

        boolean[] marked = new boolean[n + 1];
        int operations = 0;
        for (int i = 0; i < k; i++) {
            int index = changeIndices[i];
            if (lastOccurrence[index] == i) {
                if (nums[index - 1] > operations) {
                    return false;
                }
                operations -= nums[index - 1];
                marked[index] = true;
            } else {
                operations++;
            }
        }

        return true;
    }
}