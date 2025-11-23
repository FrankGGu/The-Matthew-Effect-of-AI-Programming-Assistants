class Solution {
    public int[] movesToStamp(String stamp, String target) {
        char[] S = stamp.toCharArray();
        char[] T = target.toCharArray();
        int m = stamp.length(), n = target.length();
        boolean[] visited = new boolean[n];
        int made = 0;
        List<Integer> res = new ArrayList<>();

        while (made < n) {
            boolean didChange = false;
            for (int i = 0; i <= n - m; i++) {
                if (!visited[i] && canReplace(T, S, i)) {
                    made += doReplace(T, i, m);
                    visited[i] = true;
                    res.add(i);
                    didChange = true;
                }
            }
            if (!didChange) return new int[0];
        }

        int[] ans = new int[res.size()];
        for (int i = 0; i < res.size(); i++) {
            ans[i] = res.get(res.size() - i - 1);
        }
        return ans;
    }

    private boolean canReplace(char[] T, char[] S, int p) {
        int count = 0;
        for (int i = 0; i < S.length; i++) {
            if (T[i + p] == '?') {
                continue;
            }
            if (T[i + p] != S[i]) {
                return false;
            } else {
                count++;
            }
        }
        return count > 0;
    }

    private int doReplace(char[] T, int p, int len) {
        int count = 0;
        for (int i = 0; i < len; i++) {
            if (T[i + p] != '?') {
                T[i + p] = '?';
                count++;
            }
        }
        return count;
    }
}