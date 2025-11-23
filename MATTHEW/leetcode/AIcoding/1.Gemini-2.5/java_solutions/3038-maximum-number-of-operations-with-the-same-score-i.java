class Solution {
    public int maxOperations(int[] nums) {
        if (nums.length < 2) {
            return 0;
        }

        int targetScore = nums[0] + nums[1];
        int operations = 1;

        for (int i = 2; i + 1 < nums.length; i += 2) {
            if (nums[i] + nums[i + 1] == targetScore) {
                operations++;
            } else {
                break;
            }
        }

        return operations;
    }
}