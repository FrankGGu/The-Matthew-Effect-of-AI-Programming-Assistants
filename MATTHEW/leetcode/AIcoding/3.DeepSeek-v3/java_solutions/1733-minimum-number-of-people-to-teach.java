class Solution {
    public int minimumTeachings(int n, int[][] languages, int[][] friendships) {
        int m = languages.length;
        boolean[][] canSpeak = new boolean[m + 1][n + 1];
        for (int i = 0; i < m; i++) {
            for (int lang : languages[i]) {
                canSpeak[i + 1][lang] = true;
            }
        }

        boolean[] needTeach = new boolean[m + 1];
        for (int[] friendship : friendships) {
            int u = friendship[0];
            int v = friendship[1];
            boolean canCommunicate = false;
            for (int lang = 1; lang <= n; lang++) {
                if (canSpeak[u][lang] && canSpeak[v][lang]) {
                    canCommunicate = true;
                    break;
                }
            }
            if (!canCommunicate) {
                needTeach[u] = true;
                needTeach[v] = true;
            }
        }

        int minTeach = Integer.MAX_VALUE;
        for (int lang = 1; lang <= n; lang++) {
            int count = 0;
            for (int i = 1; i <= m; i++) {
                if (needTeach[i] && !canSpeak[i][lang]) {
                    count++;
                }
            }
            minTeach = Math.min(minTeach, count);
        }

        return minTeach;
    }
}