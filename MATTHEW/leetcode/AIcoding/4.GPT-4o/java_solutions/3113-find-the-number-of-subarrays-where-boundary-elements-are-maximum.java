class Solution {
    public int countSubarrays(int[] nums) {
        int n = nums.length;
        int max = Integer.MIN_VALUE;
        for (int num : nums) {
            max = Math.max(max, num);
        }

        int count = 0;
        int length = 0;

        for (int num : nums) {
            if (num == max) {
                count += (length * (length + 1)) / 2 + 1;
                length = 0;
            } else {
                length++;
            }
        }

        count += (length * (length + 1)) / 2;

        return count;
    }
}