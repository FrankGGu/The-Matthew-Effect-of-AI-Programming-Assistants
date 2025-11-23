import java.lang.Math;

class Solution {
    public int findClosestNumber(int[] nums) {
        int closestNum = nums[0];

        for (int i = 1; i < nums.length; i++) {
            int num = nums[i];

            int currentAbs = Math.abs(num);
            int closestAbs = Math.abs(closestNum);

            if (currentAbs < closestAbs) {
                closestNum = num;
            } else if (currentAbs == closestAbs) {
                if (num > closestNum) {
                    closestNum = num;
                }
            }
        }

        return closestNum;
    }
}