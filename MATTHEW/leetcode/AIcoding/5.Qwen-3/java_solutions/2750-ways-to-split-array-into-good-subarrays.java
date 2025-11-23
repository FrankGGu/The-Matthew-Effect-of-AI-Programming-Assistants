public class Solution {

import java.util.*;

public class Solution {
    public int numSubarraysWithGoodSplit(int[] nums) {
        int count = 0;
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        for (int i = 1; i < n; i++) {
            if (prefix[i] == prefix[n] - prefix[i]) {
                count++;
            }
        }
        return count;
    }
}
}