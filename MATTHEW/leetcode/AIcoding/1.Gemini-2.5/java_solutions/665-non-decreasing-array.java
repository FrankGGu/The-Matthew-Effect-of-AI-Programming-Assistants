class Solution {
    public boolean checkPossibility(int[] nums) {
        int count = 0;
        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] > nums[i + 1]) {
                count++;
                if (count > 1) {
                    return false;
                }
                // If modifying nums[i] (making it equal to nums[i+1])
                // would maintain the non-decreasing property with nums[i-1]
                // OR if i is the first element (no nums[i-1] to check)
                if (i == 0 || nums[i - 1] <= nums[i + 1]) {
                    nums[i] = nums[i + 1];
                } else {
                    // Otherwise, we must modify nums[i+1] (making it equal to nums[i])
                    // to maintain nums[i-1] <= nums[i]
                    nums[i + 1] = nums[i];
                }
            }
        }
        return true;
    }
}