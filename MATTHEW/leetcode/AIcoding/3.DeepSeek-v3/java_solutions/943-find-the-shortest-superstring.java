class Solution {
    public String shortestSuperstring(String[] words) {
        int n = words.length;
        int[][] graph = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    graph[i][j] = calcOverlap(words[i], words[j]);
                }
            }
        }
        int[][] dp = new int[1 << n][n];
        int[][] path = new int[1 << n][n];
        int max = 0;
        int last = -1;
        for (int mask = 1; mask < (1 << n); mask++) {
            Arrays.fill(dp[mask], -1);
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) > 0) {
                    int prev = mask ^ (1 << i);
                    if (prev == 0) {
                        dp[mask][i] = words[i].length();
                    } else {
                        for (int j = 0; j < n; j++) {
                            if (dp[prev][j] != -1 && (dp[mask][i] == -1 || dp[prev][j] + graph[j][i] > dp[mask][i])) {
                                dp[mask][i] = dp[prev][j] + graph[j][i];
                                path[mask][i] = j;
                            }
                        }
                    }
                }
                if (mask == (1 << n) - 1 && dp[mask][i] > max) {
                    max = dp[mask][i];
                    last = i;
                }
            }
        }
        int curr = (1 << n) - 1;
        Stack<Integer> stack = new Stack<>();
        while (curr > 0) {
            stack.push(last);
            int next = path[curr][last];
            curr ^= (1 << last);
            last = next;
        }
        StringBuilder sb = new StringBuilder();
        int prev = stack.pop();
        sb.append(words[prev]);
        while (!stack.isEmpty()) {
            int currIdx = stack.pop();
            String currWord = words[currIdx];
            int overlap = graph[prev][currIdx];
            sb.append(currWord.substring(overlap));
            prev = currIdx;
        }
        return sb.toString();
    }

    private int calcOverlap(String a, String b) {
        int max = Math.min(a.length(), b.length());
        for (int i = max; i >= 0; i--) {
            if (a.endsWith(b.substring(0, i))) {
                return i;
            }
        }
        return 0;
    }
}