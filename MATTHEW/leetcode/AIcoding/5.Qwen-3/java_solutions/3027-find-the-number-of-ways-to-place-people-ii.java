public class Solution {

import java.util.*;

public class Solution {
    public int numberOfWays(int[][] people) {
        int n = people.length;
        Arrays.sort(people, (a, b) -> a[0] == b[0] ? b[1] - a[1] : a[0] - b[0]);

        int[] dp = new int[n];
        int[] height = new int[n];

        for (int i = 0; i < n; i++) {
            height[i] = people[i][1];
        }

        int[] BIT = new int[n + 2];

        for (int i = 0; i < n; i++) {
            int h = height[i];
            int cnt = query(BIT, h - 1);
            dp[i] = cnt;
            update(BIT, h, 1);
        }

        return Arrays.stream(dp).sum();
    }

    private void update(int[] BIT, int index, int value) {
        index++;
        while (index < BIT.length) {
            BIT[index] += value;
            index += index & -index;
        }
    }

    private int query(int[] BIT, int index) {
        index++;
        int res = 0;
        while (index > 0) {
            res += BIT[index];
            index -= index & -index;
        }
        return res;
    }
}
}