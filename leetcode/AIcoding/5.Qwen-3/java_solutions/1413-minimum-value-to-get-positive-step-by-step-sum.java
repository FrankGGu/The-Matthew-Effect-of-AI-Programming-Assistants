public class Solution {

import java.util.*;

public class Solution {
    public int minStartValue(List<Integer> nums) {
        int sum = 0;
        int minSum = 0;
        for (int num : nums) {
            sum += num;
            minSum = Math.min(minSum, sum);
        }
        return Math.max(1, 1 - minSum);
    }
}
}