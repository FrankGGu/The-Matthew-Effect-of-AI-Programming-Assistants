class Solution {
    public long countPairs(int[] nums, int k) {
        long count = 0;
        int n = nums.length;
        long[] freq = new long[k];

        for (int num : nums) {
            freq[(num % k + k) % k]++;
        }

        for (int i = 0; i < k; i++) {
            count += freq[i] * freq[(k - i) % k];
        }

        count -= freq[0] * freq[0];
        count /= 2;

        return count + freq[0] * (freq[0] - 1) / 2;
    }
}