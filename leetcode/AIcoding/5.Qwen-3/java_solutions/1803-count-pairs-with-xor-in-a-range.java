public class Solution {

import java.util.*;

public class Solution {
    public int countPairs(int[] nums, int low, int high) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if ((nums[i] ^ nums[j]) >= low && (nums[i] ^ nums[j]) <= high) {
                    count++;
                }
            }
        }
        return count;
    }
}
}