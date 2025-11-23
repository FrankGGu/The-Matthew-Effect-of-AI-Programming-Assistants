class Solution {
    public long minSum(int[] nums1, int[] nums2) {
        long sum1 = 0, sum2 = 0;
        int zeros1 = 0, zeros2 = 0;
        for (int num : nums1) {
            sum1 += num;
            if (num == 0) {
                zeros1++;
            }
        }
        for (int num : nums2) {
            sum2 += num;
            if (num == 0) {
                zeros2++;
            }
        }

        if (sum1 + zeros1 < sum2 + zeros2 && zeros1 == 0) return -1;
        if (sum2 + zeros2 < sum1 + zeros1 && zeros2 == 0) return -1;

        long target1 = Math.max(sum1 + zeros1, sum2 + zeros2);
        long target2 = Math.max(sum1 + zeros1, sum2 + zeros2);

        return target1;
    }
}