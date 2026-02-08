public class Solution {

import java.util.*;

public class Solution {
    public int numShortestSupersequences(int[] nums1, int[] nums2) {
        int n = nums1.length, m = nums2.length;
        Map<Integer, Deque<Integer>> map = new HashMap<>();
        for (int i = 0; i < m; i++) {
            map.putIfAbsent(nums2[i], new LinkedList<>());
            map.get(nums2[i]).addLast(i);
        }

        int[] dp = new int[m + 1];
        Arrays.fill(dp, 1);
        for (int i = 0; i < n; i++) {
            int[] newDp = new int[m + 1];
            Arrays.fill(newDp, 1);
            for (int j = 0; j <= m; j++) {
                if (j == 0) {
                    newDp[j] = 1;
                } else {
                    newDp[j] = dp[j];
                    if (nums1[i] == nums2[j - 1]) {
                        if (j > 0) {
                            newDp[j] = dp[j - 1];
                        }
                    } else {
                        newDp[j] = dp[j];
                    }
                }
            }
            dp = newDp;
        }

        return dp[m];
    }
}
}