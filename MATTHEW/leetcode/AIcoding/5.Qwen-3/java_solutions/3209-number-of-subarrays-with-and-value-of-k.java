public class Solution {

import java.util.*;

public class Solution {
    public int numSubarraysWithAndK(int[] nums, int k) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            int andVal = nums[i];
            if (andVal == k) count++;
            for (int j = i + 1; j < n; j++) {
                andVal &= nums[j];
                if (andVal == k) count++;
            }
        }
        return count;
    }
}
}