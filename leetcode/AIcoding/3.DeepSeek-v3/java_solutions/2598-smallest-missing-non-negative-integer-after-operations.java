class Solution {
    public int findSmallestInteger(int[] nums, int value) {
        int[] count = new int[value];
        for (int num : nums) {
            int mod = (num % value + value) % value;
            count[mod]++;
        }
        int minCount = Integer.MAX_VALUE;
        int minIndex = 0;
        for (int i = 0; i < value; i++) {
            if (count[i] < minCount) {
                minCount = count[i];
                minIndex = i;
            }
        }
        return minCount * value + minIndex;
    }
}