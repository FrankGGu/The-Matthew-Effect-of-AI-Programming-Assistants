class Solution {
    public int countHillValley(int[] nums) {
        int count = 0;
        int prev = nums[0];
        for (int i = 1; i < nums.length - 1; i++) {
            if (nums[i] != prev) {
                int next = i + 1;
                while (next < nums.length && nums[next] == nums[i]) {
                    next++;
                }
                if (next < nums.length) {
                    if ((nums[i] > prev && nums[i] > nums[next]) || (nums[i] < prev && nums[i] < nums[next])) {
                        count++;
                    }
                    prev = nums[i];
                } else {
                    break;
                }
            }
        }
        return count;
    }
}