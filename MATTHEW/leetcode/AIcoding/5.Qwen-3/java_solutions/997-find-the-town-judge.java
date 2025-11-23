public class Solution {

import java.util.*;

public class Solution {
    public int findJudge(int n, int[][] trust) {
        int[] count = new int[n + 1];
        boolean[] isTrusted = new boolean[n + 1];

        for (int[] t : trust) {
            int a = t[0];
            int b = t[1];
            count[b]++;
            isTrusted[a] = true;
        }

        for (int i = 1; i <= n; i++) {
            if (!isTrusted[i] && count[i] == n - 1) {
                return i;
            }
        }

        return -1;
    }
}
}