public class Solution {

import java.util.*;

public class Solution {
    public int beautifulSplits(int[] nums) {
        int n = nums.length;
        int count = 0;
        for (int i = 1; i < n - 1; i++) {
            Set<Integer> left = new HashSet<>();
            Set<Integer> right = new HashSet<>();
            for (int j = 0; j <= i; j++) {
                left.add(nums[j]);
            }
            for (int j = i + 1; j < n; j++) {
                right.add(nums[j]);
            }
            if (left.size() == right.size()) {
                count++;
            }
        }
        return count;
    }
}
}