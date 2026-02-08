import java.util.*;

class Solution {
    public int[] shortestSupersequence(int[] big, int[] small) {
        int n = big.length;
        int m = small.length;
        Map<Integer, List<Integer>> pos = new HashMap<>();
        for (int i = 0; i < n; i++) {
            pos.computeIfAbsent(big[i], k -> new ArrayList<>()).add(i);
        }

        int[] dp = new int[n];
        Arrays.fill(dp, -1);
        int len = Integer.MAX_VALUE;
        int start = -1;

        for (int i = 0; i < n; i++) {
            if (big[i] == small[0]) {
                dp[i] = i;
            }
        }

        for (int i = 1; i < m; i++) {
            int[] newDp = new int[n];
            Arrays.fill(newDp, -1);
            for (int j = 0; j < n; j++) {
                if (dp[j] != -1) {
                    List<Integer> list = pos.get(small[i]);
                    if (list != null) {
                        int next = -1;
                        int l = 0, r = list.size() - 1;
                        while (l <= r) {
                            int mid = (l + r) / 2;
                            if (list.get(mid) > j) {
                                next = list.get(mid);
                                r = mid - 1;
                            } else {
                                l = mid + 1;
                            }
                        }
                        if (next != -1) {
                            newDp[next] = dp[j];
                        }
                    }
                }
            }
            dp = newDp;
        }

        for (int i = 0; i < n; i++) {
            if (dp[i] != -1) {
                if (i - dp[i] + 1 < len) {
                    len = i - dp[i] + 1;
                    start = dp[i];
                }
            }
        }

        if (start == -1) {
            return new int[0];
        }

        return new int[] {start, start + len - 1};
    }
}