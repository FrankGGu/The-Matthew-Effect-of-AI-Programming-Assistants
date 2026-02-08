import java.util.Arrays;

class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        if (6 * Math.min(nums1.length, nums2.length) < Math.max(nums1.length, nums2.length)) {
            return -1;
        }

        int sum1 = 0;
        for (int num : nums1) {
            sum1 += num;
        }

        int sum2 = 0;
        for (int num : nums2) {
            sum2 += num;
        }

        if (sum1 == sum2) {
            return 0;
        }

        if (sum1 < sum2) {
            int[] tempArr = nums1;
            nums1 = nums2;
            nums2 = tempArr;

            int tempSum = sum1;
            sum1 = sum2;
            sum2 = tempSum;
        }

        int diff = sum1 - sum2;
        int operations = 0;

        int[] gains = new int[6]; 

        for (int num : nums1) {
            gains[num - 1]++;
        }

        for (int num : nums2) {
            gains[6 - num]++;
        }

        for (int k = 5; k >= 1; k--) {
            while (gains[k] > 0 && diff > 0) {
                diff -= k;
                operations++;
                gains[k]--;
            }
            if (diff <= 0) {
                break;
            }
        }

        return operations;
    }
}