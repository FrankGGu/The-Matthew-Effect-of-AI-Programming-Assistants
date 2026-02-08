import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int[] maxSubsequence(int[] nums, int k) {
        int n = nums.length;
        int[][] indexedNums = new int[n][2];
        for (int i = 0; i < n; i++) {
            indexedNums[i][0] = nums[i];
            indexedNums[i][1] = i;
        }

        Arrays.sort(indexedNums, (a, b) -> b[0] - a[0]);

        int[][] kLargest = new int[k][2];
        for (int i = 0; i < k; i++) {
            kLargest[i] = indexedNums[i];
        }

        Arrays.sort(kLargest, (a, b) -> a[1] - b[1]);

        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = kLargest[i][0];
        }

        return result;
    }
}