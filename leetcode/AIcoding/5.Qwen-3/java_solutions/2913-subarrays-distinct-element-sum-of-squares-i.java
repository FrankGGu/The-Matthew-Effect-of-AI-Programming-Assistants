public class Solution {

import java.util.*;

public class Solution {
    public int sumOfPowers(int[] nums) {
        int n = nums.length;
        int result = 0;
        for (int i = 0; i < n; i++) {
            Set<Integer> unique = new HashSet<>();
            for (int j = i; j < n; j++) {
                unique.add(nums[j]);
                result += unique.size() * unique.size();
            }
        }
        return result;
    }
}
}