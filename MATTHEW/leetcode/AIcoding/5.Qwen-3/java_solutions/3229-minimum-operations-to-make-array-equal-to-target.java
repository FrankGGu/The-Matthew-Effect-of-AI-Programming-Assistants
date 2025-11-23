public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] target, int[] arr) {
        Map<Integer, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < target.length; i++) {
            indexMap.put(target[i], i);
        }

        List<Integer> sequence = new ArrayList<>();
        for (int num : arr) {
            if (indexMap.containsKey(num)) {
                sequence.add(indexMap.get(num));
            }
        }

        int[] dp = new int[sequence.size()];
        int maxLength = 0;

        for (int i = 0; i < sequence.size(); i++) {
            dp[i] = 1;
            for (int j = 0; j < i; j++) {
                if (sequence.get(i) > sequence.get(j)) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
            maxLength = Math.max(maxLength, dp[i]);
        }

        return target.length - maxLength;
    }
}
}