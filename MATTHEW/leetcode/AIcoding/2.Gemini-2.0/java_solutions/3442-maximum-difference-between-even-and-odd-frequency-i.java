class Solution {
    public int maxFrequencyDifference(int[] nums) {
        int n = nums.length;
        int[] freq = new int[201];
        for (int num : nums) {
            freq[num + 100]++;
        }

        int maxEven = Integer.MIN_VALUE;
        int maxOdd = Integer.MIN_VALUE;

        for (int i = 0; i < 201; i++) {
            if (freq[i] > 0) {
                if ((i - 100) % 2 == 0) {
                    maxEven = Math.max(maxEven, freq[i]);
                } else {
                    maxOdd = Math.max(maxOdd, freq[i]);
                }
            }
        }

        if (maxEven == Integer.MIN_VALUE) return -maxOdd;
        if (maxOdd == Integer.MIN_VALUE) return maxEven;

        return maxEven - maxOdd;
    }
}