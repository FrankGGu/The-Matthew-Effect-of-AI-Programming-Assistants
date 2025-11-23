public class Solution {

import java.util.*;

public class Solution {
    public int sumOfArrayProductOfMagicalSequences(int[] nums) {
        int n = nums.length;
        int result = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int product = nums[i] * nums[j];
                result += product;
            }
        }
        return result;
    }
}
}