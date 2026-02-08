class Solution {
    public int maximumLength(int[] nums, int k) {
        int[] counts = new int[k];

        for (int num : nums) {
            int remainder = num % k;
            counts[remainder]++;
        }

        int maxLength = 0;
        for (int count : counts) {
            if (count > maxLength) {
                maxLength = count;
            }
        }

        return maxLength;
    }
}