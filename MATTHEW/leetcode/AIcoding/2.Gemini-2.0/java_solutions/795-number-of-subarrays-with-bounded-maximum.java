class Solution {
    public int numSubarrayBoundedMax(int[] nums, int left, int right) {
        int count = 0;
        int start = -1;
        int end = -1;

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] >= left && nums[i] <= right) {
                end = i;
                count += (end - start);
            } else if (nums[i] < left) {
                if (end != -1) {
                    count += (end - start);
                }
            } else {
                start = i;
                end = -1;
            }
        }

        return count;
    }
}