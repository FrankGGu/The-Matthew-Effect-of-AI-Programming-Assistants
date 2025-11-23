import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private int getMaxDigit(int n) {
        int maxD = 0;
        while (n > 0) {
            maxD = Math.max(maxD, n % 10);
            n /= 10;
        }
        return maxD;
    }

    public int maxSum(int[] nums) {
        Map<Integer, List<Integer>> digitGroups = new HashMap<>();

        for (int num : nums) {
            int maxDigit = getMaxDigit(num);
            digitGroups.computeIfAbsent(maxDigit, k -> new ArrayList<>()).add(num);
        }

        int maxSum = -1;

        for (List<Integer> group : digitGroups.values()) {
            if (group.size() < 2) {
                continue;
            }

            int firstMax = -1;
            int secondMax = -1;

            for (int val : group) {
                if (val > firstMax) {
                    secondMax = firstMax;
                    firstMax = val;
                } else if (val > secondMax) {
                    secondMax = val;
                }
            }

            maxSum = Math.max(maxSum, firstMax + secondMax);
        }

        return maxSum;
    }
}