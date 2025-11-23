public class Solution {

import java.util.*;

public class Solution {
    public int maximumCount(int[] nums) {
        int negative = 0;
        int positive = 0;
        for (int num : nums) {
            if (num < 0) negative++;
            else if (num > 0) positive++;
        }
        return Math.max(negative, positive);
    }
}
}