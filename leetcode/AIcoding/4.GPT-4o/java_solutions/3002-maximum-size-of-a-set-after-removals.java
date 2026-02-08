class Solution {
    public int maximumSize(int[] nums, int maxRemovals) {
        int left = 1, right = nums.length;
        Arrays.sort(nums);

        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (canRemove(nums, mid, maxRemovals)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        return left;
    }

    private boolean canRemove(int[] nums, int size, int maxRemovals) {
        int removals = 0, prev = -1;
        for (int i = 0; i < nums.length; i++) {
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue;
            }
            if (i < size) {
                prev = nums[i];
            } else {
                if ((nums[i] - prev) <= 1) {
                    removals++;
                } else {
                    prev = nums[i];
                }
            }
            if (removals > maxRemovals) {
                return false;
            }
        }
        return true;
    }
}