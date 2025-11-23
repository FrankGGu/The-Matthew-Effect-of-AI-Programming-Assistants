import java.util.List;

class Solution {
    public int minimumRightShifts(List<Integer> nums) {
        int n = nums.size();
        int descentCount = 0;
        int pivotIndex = -1; 

        for (int i = 0; i < n - 1; i++) {
            if (nums.get(i) > nums.get(i + 1)) {
                descentCount++;
                pivotIndex = i;
            }
        }

        if (descentCount == 0) {
            return 0;
        } else if (descentCount == 1) {
            if (nums.get(n - 1) < nums.get(0)) {
                return n - (pivotIndex + 1);
            } else {
                return -1;
            }
        } else {
            return -1;
        }
    }
}