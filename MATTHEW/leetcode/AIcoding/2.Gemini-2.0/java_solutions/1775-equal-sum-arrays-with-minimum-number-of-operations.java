import java.util.Arrays;

class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        int sum1 = 0, sum2 = 0;
        for (int num : nums1) sum1 += num;
        for (int num : nums2) sum2 += num;

        if (sum1 == sum2) return 0;
        if (sum1 > sum2) return minOperationsHelper(nums1, nums2);
        else return minOperationsHelper(nums2, nums1);
    }

    private int minOperationsHelper(int[] nums1, int[] nums2) {
        int sum1 = 0, sum2 = 0;
        for (int num : nums1) sum1 += num;
        for (int num : nums2) sum2 += num;

        Arrays.sort(nums1);
        Arrays.sort(nums2);

        int i = 0, j = nums2.length - 1;
        int operations = 0;

        while (sum1 > sum2) {
            if (i < nums1.length && j >= 0) {
                if (6 - nums1[i] > nums2[j] - 1) {
                    sum1 -= (nums1[i] - 1);
                    i++;
                } else {
                    sum2 += (6 - nums2[j]);
                    j--;
                }
            } else if (i < nums1.length) {
                sum1 -= (nums1[i] - 1);
                i++;
            } else {
                sum2 += (6 - nums2[j]);
                j--;
            }
            operations++;

            if (operations > (nums1.length + nums2.length)) return -1;
        }

        return operations;
    }
}