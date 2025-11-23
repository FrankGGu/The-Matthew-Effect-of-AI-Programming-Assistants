public class Solution {

import java.util.*;

public class Solution {
    public int countLargestGroup(int n) {
        Map<Integer, Integer> groupCount = new HashMap<>();

        for (int i = 1; i <= n; i++) {
            int sum = 0;
            int num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            groupCount.put(sum, groupCount.getOrDefault(sum, 0) + 1);
        }

        int maxCount = 0;
        int count = 0;

        for (int value : groupCount.values()) {
            if (value > maxCount) {
                maxCount = value;
                count = 1;
            } else if (value == maxCount) {
                count++;
            }
        }

        return count;
    }
}
}