public class Solution {

import java.util.Arrays;

public class Solution {
    public int[] advantageCount(int[] nums, int[] cost) {
        int n = nums.length;
        int[][] sorted = new int[n][2];
        for (int i = 0; i < n; i++) {
            sorted[i][0] = nums[i];
            sorted[i][1] = i;
        }
        Arrays.sort(sorted, (a, b) -> a[0] - b[0]);
        Arrays.sort(cost);
        int[] result = new int[n];
        int left = 0, right = n - 1;
        for (int i = n - 1; i >= 0; i--) {
            if (cost[i] > sorted[left][0]) {
                result[sorted[left][1]] = cost[i];
                left++;
            } else {
                result[sorted[right][1]] = cost[i];
                right--;
            }
        }
        return result;
    }
}
}