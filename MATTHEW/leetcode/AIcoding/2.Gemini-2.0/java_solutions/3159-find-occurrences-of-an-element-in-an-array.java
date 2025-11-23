class Solution {
    public int[] findOccurrences(int[] nums, int target) {
        int count = 0;
        for (int num : nums) {
            if (num == target) {
                count++;
            }
        }

        int[] result = new int[count];
        int index = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == target) {
                result[index++] = i;
            }
        }

        return result;
    }
}