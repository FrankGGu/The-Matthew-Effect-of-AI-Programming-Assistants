public class Solution {
    public int[] getSubarrayBeauties(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n - k + 1];
        int[] count = new int[101]; // since nums[i] is between 1 and 100 inclusive

        for (int i = 0; i < k; i++) {
            count[nums[i]]++;
        }

        for (int i = 0; i < n - k + 1; i++) {
            int beauty = 0;
            for (int j = 1; j <= 100; j++) {
                if (count[j] > 0) {
                    beauty = j;
                    break;
                }
            }
            result[i] = beauty;

            if (i < n - k) {
                count[nums[i]]--;
                count[nums[i + k]]++;
            }
        }

        return result;
    }
}