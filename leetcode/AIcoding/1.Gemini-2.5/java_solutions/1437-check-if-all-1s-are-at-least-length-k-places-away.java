class Solution {
    public boolean kLengthApart(int[] nums, int k) {
        int lastOneIndex = -k - 1; 

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                if (i - lastOneIndex <= k) {
                    return false;
                }
                lastOneIndex = i;
            }
        }
        return true;
    }
}