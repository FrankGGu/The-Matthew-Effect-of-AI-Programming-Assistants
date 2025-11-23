class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        int sum1 = 0, sum2 = 0;
        for (int num : nums1) sum1 += num;
        for (int num : nums2) sum2 += num;

        if (sum1 == sum2) return 0;
        if (sum1 > sum2) return minOperations(nums2, nums1);

        int diff = sum2 - sum1;
        int[] count = new int[6];
        for (int num : nums1) count[6 - num]++;
        for (int num : nums2) count[num - 1]++;

        int res = 0;
        for (int i = 5; i >= 1 && diff > 0; --i) {
            int take = Math.min(count[i], (diff + i - 1) / i);
            res += take;
            diff -= take * i;
        }
        return diff <= 0 ? res : -1;
    }
}