public class Solution {
    public int minimumRightShifts(int[] nums) {
        int n = nums.length;
        int shifts = 0;

        for (int i = 0; i < n - 1; i++) {
            if (nums[i] > nums[i + 1]) {
                shifts = n - i - 1;
                break;
            }
        }

        for (int i = 0; i < n - 1; i++) {
            if (nums[(i + shifts) % n] > nums[(i + shifts + 1) % n]) {
                return -1;
            }
        }

        return shifts;
    }
}