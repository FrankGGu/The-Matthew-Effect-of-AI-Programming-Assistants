class Solution {
    public int maxOperations(int[] nums) {
        int n = nums.length;
        int count = 0;
        if (n < 2) {
            return 0;
        }

        int target = nums[0] + nums[1];
        count++;

        for (int i = 2; i < n - 1; i += 2) {
            if (nums[i] + nums[i + 1] == target) {
                count++;
            } else {
                break;
            }
        }

        return count;
    }
}