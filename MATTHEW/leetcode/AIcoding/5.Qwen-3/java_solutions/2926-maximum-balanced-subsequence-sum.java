public class Solution {

import java.util.*;

public class Solution {
    public int maxBalancedSubsequenceSum(int[] nums) {
        int n = nums.length;
        List<int[]> pairs = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            pairs.add(new int[]{nums[i], i});
        }
        Collections.sort(pairs, (a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

        int[] dp = new int[n];
        int[] index = new int[n];
        for (int i = 0; i < n; i++) {
            index[i] = pairs.get(i)[1];
            dp[i] = pairs.get(i)[0];
        }

        int[] BIT = new int[n + 1];

        for (int i = 0; i < n; i++) {
            int pos = index[i] + 1;
            int maxVal = query(BIT, pos - 1);
            dp[i] = Math.max(dp[i], maxVal + pairs.get(i)[0]);
            update(BIT, pos, dp[i]);
        }

        return Arrays.stream(dp).max().getAsInt();
    }

    private void update(int[] BIT, int index, int value) {
        while (index < BIT.length) {
            BIT[index] = Math.max(BIT[index], value);
            index += index & -index;
        }
    }

    private int query(int[] BIT, int index) {
        int maxVal = Integer.MIN_VALUE;
        while (index > 0) {
            maxVal = Math.max(maxVal, BIT[index]);
            index -= index & -index;
        }
        return maxVal;
    }
}
}