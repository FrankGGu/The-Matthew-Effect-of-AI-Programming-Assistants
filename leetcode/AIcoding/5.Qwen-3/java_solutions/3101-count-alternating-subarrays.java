public class Solution {

import java.util.*;

public class Solution {
    public int countAlternatingSubarrays(int[] nums) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            int j = i;
            while (j < n - 1 && nums[j] != nums[j + 1]) {
                j++;
            }
            int length = j - i + 1;
            count += length * (length + 1) / 2;
            i = j;
        }
        return count;
    }
}
}