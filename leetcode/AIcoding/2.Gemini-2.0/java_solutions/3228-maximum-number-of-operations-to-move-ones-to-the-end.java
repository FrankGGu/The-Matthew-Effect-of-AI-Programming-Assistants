class Solution {
    public int maxOperations(int[] nums) {
        int n = nums.length;
        int count = 0;
        int left = 0;
        int right = n - 1;

        while (left < right) {
            if (nums[left] == 1) {
                left++;
                continue;
            }
            if (nums[right] == 0) {
                right--;
                continue;
            }

            if (nums[left] == 0 && nums[right] == 1) {
                int temp = nums[left];
                nums[left] = nums[right];
                nums[right] = temp;
                count++;
                left++;
                right--;
            } else if (nums[left] == 0 && nums[right] == 0) {
                right--;
            } else if (nums[left] == 1 && nums[right] == 1) {
                left++;
            } else {
                left++;
                right--;
            }
        }

        return count;
    }
}