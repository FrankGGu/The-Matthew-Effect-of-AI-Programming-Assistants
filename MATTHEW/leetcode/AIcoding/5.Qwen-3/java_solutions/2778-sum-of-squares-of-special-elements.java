public class Solution {

import java.util.*;

public class Solution {
    public int sumOfSquares(List<Integer> nums) {
        int n = nums.size();
        int result = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                result += nums.get(i) * nums.get(i);
            }
        }
        return result;
    }
}
}