class Solution {
    public String shortestSuperstring(String[] A) {
        int n = A.length;
        int[][] overlap = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) continue;
                int len = Math.min(A[i].length(), A[j].length());
                for (int k = len; k > 0; k--) {
                    if (A[i].substring(A[i].length() - k).equals(A[j].substring(0, k))) {
                        overlap[i][j] = k;
                        break;
                    }
                }
            }
        }

        int[][] dp = new int[1 << n][n];
        int[][] path = new int[1 << n][n];
        int last = -1, min = Integer.MAX_VALUE;

        for (int mask = 1; mask < (1 << n); mask++) {
            for (int j = 0; j < n; j++) {
                if ((mask & (1 << j)) > 0) {
                    int prevMask = mask ^ (1 << j);
                    if (prevMask == 0) {
                        dp[mask][j] = A[j].length();
                    } else {
                        for (int i = 0; i < n; i++) {
                            if ((prevMask & (1 << i)) > 0) {
                                int val = dp[prevMask][i] + A[j].length() - overlap[i][j];
                                if (val > dp[mask][j]) {
                                    dp[mask][j] = val;
                                    path[mask][j] = i;
                                }
                            }
                        }
                    }
                }
            }
        }

        int mask = (1 << n) - 1;
        for (int j = 0; j < n; j++) {
            if (dp[mask][j] > min) {
                min = dp[mask][j];
                last = j;
            }
        }

        StringBuilder sb = new StringBuilder();
        boolean[] used = new boolean[n];
        for (int i = 0; i < n; i++) {
            used[last] = true;
            sb.append(A[last]);
            int temp = last;
            last = path[mask][last];
            mask ^= (1 << temp);
        }

        String ans = sb.reverse().toString();
        StringBuilder res = new StringBuilder();
        int idx = 0;
        for(int i = n - 1; i >= 0; i--){
            if(!used[i]){
                res.append(A[i]);
            } else {
                break;
            }
        }

        for(int i = 0; i < n; i++){
            if(used[i]){
                idx = i;
                break;
            }
        }

        res.append(ans);

        return res.toString();
    }
}