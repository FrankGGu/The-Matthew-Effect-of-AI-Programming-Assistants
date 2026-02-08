public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int maximumSum(int[] nums) {
        Map<Integer, Integer> sumMap = new HashMap<>();
        int maxSum = -1;

        for (int num : nums) {
            int digitSum = 0;
            int n = Math.abs(num);
            while (n > 0) {
                digitSum += n % 10;
                n /= 10;
            }

            if (sumMap.containsKey(digitSum)) {
                int prev = sumMap.get(digitSum);
                maxSum = Math.max(maxSum, prev + num);
                sumMap.put(digitSum, Math.max(prev, num));
            } else {
                sumMap.put(digitSum, num);
            }
        }

        return maxSum;
    }
}
}