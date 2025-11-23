public class Solution {

import java.util.*;

public class Solution {
    public int numberOfSubarrays(int[] nums) {
        int n = nums.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            int max = nums[i];
            for (int j = i; j < n; j++) {
                if (nums[j] > max) {
                    max = nums[j];
                    count++;
                } else {
                    break;
                }
            }
        }
        return count;
    }
}
}