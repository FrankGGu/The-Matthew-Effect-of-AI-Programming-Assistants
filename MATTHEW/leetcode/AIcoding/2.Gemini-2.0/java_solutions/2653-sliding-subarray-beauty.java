import java.util.Arrays;

class Solution {
    public int[] getSubarrayBeauty(int[] nums, int k, int x) {
        int n = nums.length;
        int[] result = new int[n - k + 1];
        int[] subarray = new int[k];

        for (int i = 0; i <= n - k; i++) {
            for (int j = 0; j < k; j++) {
                subarray[j] = nums[i + j];
            }
            Arrays.sort(subarray);
            int count = 0;
            for (int j = 0; j < k; j++) {
                if (subarray[j] < 0) {
                    count++;
                }
                if (count == x) {
                    result[i] = subarray[j];
                    break;
                }
            }
            if (count < x) {
                result[i] = 0;
            }
        }

        return result;
    }
}