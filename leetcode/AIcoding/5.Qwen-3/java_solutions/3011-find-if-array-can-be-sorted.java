public class Solution {

import java.util.Arrays;

public class Solution {
    public boolean canBeSorted(int[] nums) {
        int[] sorted = nums.clone();
        Arrays.sort(sorted);

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] != sorted[i]) {
                int j = i + 1;
                while (j < nums.length && nums[j] == nums[i]) {
                    j++;
                }
                if (j < nums.length && nums[j] != sorted[i]) {
                    return false;
                }
                for (int k = i; k < j; k++) {
                    if (nums[k] != sorted[k]) {
                        return false;
                    }
                }
                i = j - 1;
            }
        }
        return true;
    }
}
}