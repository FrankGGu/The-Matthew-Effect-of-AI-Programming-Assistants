class Solution {
    public int[] smallerNumbersThanCurrent(int[] nums) {
        int[] result = new int[nums.length];
        int[] count = new int[101];

        for (int num : nums) {
            count[num]++;
        }

        for (int i = 1; i < count.length; i++) {
            count[i] += count[i - 1];
        }

        for (int i = 0; i < nums.length; i++) {
            result[i] = nums[i] > 0 ? count[nums[i] - 1] : 0;
        }

        return result;
    }
}