public class Solution {

import java.util.*;

public class Solution {
    public int maximumTripletValue(int[] nums) {
        int n = nums.length;
        int maxVal = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (nums[i] > nums[j]) {
                    for (int k = j + 1; k < n; k++) {
                        if (nums[j] > nums[k]) {
                            maxVal = Math.max(maxVal, nums[i] - nums[j] + nums[k]);
                        }
                    }
                }
            }
        }
        return maxVal;
    }
}
}