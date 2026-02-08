public class FreedomTrail {

    public int findRotateSteps(String ring, String key) {
        int n = ring.length();
        int m = key.length();
        int[][] pos = new int[26][];
        for (int i = 0; i < 26; i++) {
            pos[i] = new int[0];
        }
        for (int i = 0; i < n; i++) {
            char c = ring.charAt(i);
            int index = c - 'a';
            int[] arr = pos[index];
            int[] newArr = new int[arr.length + 1];
            System.arraycopy(arr, 0, newArr, 0, arr.length);
            newArr[arr.length] = i;
            pos[index] = newArr;
        }

        int[][] dp = new int[m + 1][n];
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j] = 1000000;
            }
        }
        dp[0][0] = 0;

        for (int i = 0; i < m; i++) {
            char c = key.charAt(i);
            int[] arr = pos[c - 'a'];
            for (int j = 0; j < n; j++) {
                if (dp[i][j] == 1000000) continue;
                for (int k = 0; k < arr.length; k++) {
                    int nextPos = arr[k];
                    int diff = Math.abs(nextPos - j);
                    int steps = Math.min(diff, n - diff);
                    dp[i + 1][nextPos] = Math.min(dp[i + 1][nextPos], dp[i][j] + steps + 1);
                }
            }
        }

        int ans = 1000000;
        for (int i = 0; i < n; i++) {
            ans = Math.min(ans, dp[m][i]);
        }
        return ans;
    }
}