class Solution {
    public long minSumSquareDiff(int[] nums1, int[] nums2, int k1, int k2) {
        int n = nums1.length;
        int[] diff = new int[n];
        for (int i = 0; i < n; i++) {
            diff[i] = Math.abs(nums1[i] - nums2[i]);
        }
        int max = 0;
        for (int num : diff) {
            max = Math.max(max, num);
        }
        int[] freq = new int[max + 1];
        for (int num : diff) {
            freq[num]++;
        }
        int k = k1 + k2;
        for (int i = max; i > 0 && k > 0; i--) {
            int reduce = Math.min(k, freq[i]);
            freq[i] -= reduce;
            freq[i - 1] += reduce;
            k -= reduce;
        }
        long res = 0;
        for (int i = 1; i <= max; i++) {
            res += (long) freq[i] * i * i;
        }
        return res;
    }
}