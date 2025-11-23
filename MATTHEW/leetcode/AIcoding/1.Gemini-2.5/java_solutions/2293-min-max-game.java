class Solution {
    public int minMaxGame(int[] nums) {
        if (nums.length == 1) {
            return nums[0];
        }

        int currentLength = nums.length;
        int roundNum = 0;

        while (currentLength > 1) {
            int[] newNums = new int[currentLength / 2];
            for (int i = 0; i < currentLength / 2; i++) {
                if (roundNum % 2 == 0) { // Even-indexed operation
                    newNums[i] = Math.min(nums[2 * i], nums[2 * i + 1]);
                } else { // Odd-indexed operation
                    newNums[i] = Math.max(nums[2 * i], nums[2 * i + 1]);
                }
            }
            nums = newNums;
            currentLength /= 2;
            roundNum++;
        }

        return nums[0];
    }
}