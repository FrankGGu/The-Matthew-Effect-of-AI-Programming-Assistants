public class Solution {

import java.util.*;

public class Solution {
    public int boxDelivering(int[][] boxes, int portCount) {
        int n = boxes.length;
        int[] dp = new int[n + 1];
        int[] pre = new int[n + 1];
        Deque<Integer> q = new ArrayDeque<>();
        q.add(0);

        for (int i = 1; i <= n; i++) {
            pre[i] = pre[i - 1] + boxes[i - 1][1];
        }

        for (int i = 1; i <= n; i++) {
            while (!q.isEmpty() && pre[i] - pre[q.peek()] > portCount) {
                q.poll();
            }

            if (!q.isEmpty()) {
                dp[i] = dp[q.peek()] + (pre[i] - pre[q.peek()]);
            } else {
                dp[i] = pre[i];
            }

            while (!q.isEmpty() && dp[i] <= dp[q.getLast()]) {
                q.pollLast();
            }

            q.add(i);
        }

        return dp[n];
    }
}
}