class Solution {
    public int countGoodTriplets(int[] nums) {
        int count = 0;
        for (int i = 0; i <= nums.length - 3; i++) {
            if (nums[i] < nums[i+1] && nums[i+1] < nums[i+2]) {
                count++;
            }
        }
        return count;
    }
}