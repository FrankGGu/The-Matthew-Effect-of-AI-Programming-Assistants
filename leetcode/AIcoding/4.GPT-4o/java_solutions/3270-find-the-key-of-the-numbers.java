class Solution {
    public int findKey(int[] nums, int target) {
        for (int num : nums) {
            if (num == target) {
                return num;
            }
        }
        return -1; // Return -1 if target is not found
    }
}