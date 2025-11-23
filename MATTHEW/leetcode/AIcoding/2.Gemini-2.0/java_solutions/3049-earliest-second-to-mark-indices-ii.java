import java.util.Arrays;

class Solution {
    public int earliestSecondToMarkIndices(int[] nums, int[] changeIndices) {
        int n = nums.length;
        int m = changeIndices.length;

        int low = 1, high = m;
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canMark(nums, changeIndices, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }

    private boolean canMark(int[] nums, int[] changeIndices, int time) {
        int n = nums.length;
        int[] lastOccurrence = new int[n + 1];
        Arrays.fill(lastOccurrence, -1);

        for (int i = 0; i < time; i++) {
            lastOccurrence[changeIndices[i]] = i;
        }

        for (int i = 1; i <= n; i++) {
            if (lastOccurrence[i] == -1) {
                return false;
            }
        }

        boolean[] marked = new boolean[n + 1];
        int operations = 0;
        for (int i = 0; i < time; i++) {
            int index = changeIndices[i];
            if (lastOccurrence[index] == i) {
                if (nums[index - 1] <= operations) {
                    marked[index] = true;
                    operations -= nums[index - 1];
                    operations++;
                } else {
                    return false;
                }
            } else {
                operations++;
            }
            if (operations > time) return false;
        }

        for (int i = 1; i <= n; i++) {
            if (!marked[i]) {
                return false;
            }
        }

        return true;
    }
}