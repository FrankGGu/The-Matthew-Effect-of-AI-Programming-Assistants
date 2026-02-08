public class Solution {

import java.util.*;

public class Solution {
    public int countGreatEnoughSubarrays(int[] nums, int k) {
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int result = 0;
        int left = 0;
        for (int right = 0; right < n; right++) {
            while (prefix[right + 1] - prefix[left] >= k) {
                left++;
            }
            result += left;
        }
        return result;
    }
}
}