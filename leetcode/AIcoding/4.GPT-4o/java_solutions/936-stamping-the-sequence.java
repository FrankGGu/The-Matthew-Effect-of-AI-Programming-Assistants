class Solution {
    public List<Integer> movesToStamp(String stamp, String target) {
        int m = stamp.length(), n = target.length();
        boolean[] visited = new boolean[n];
        List<Integer> res = new ArrayList<>();
        int count = 0;

        while (count < n) {
            boolean done = false;
            for (int i = 0; i <= n - m; i++) {
                if (!visited[i] && canStamp(stamp, target, i)) {
                    count = applyStamp(visited, count, i, m);
                    res.add(i);
                    done = true;
                }
            }
            if (!done) break;
        }

        if (count == n) {
            Collections.reverse(res);
            return res;
        }
        return new ArrayList<>();
    }

    private boolean canStamp(String stamp, String target, int start) {
        for (int i = 0; i < stamp.length(); i++) {
            if (target.charAt(start + i) != stamp.charAt(i) && target.charAt(start + i) != '*') {
                return false;
            }
        }
        return true;
    }

    private int applyStamp(boolean[] visited, int count, int start, int m) {
        for (int i = 0; i < m; i++) {
            if (!visited[start + i]) {
                visited[start + i] = true;
                count++;
            }
        }
        return count;
    }
}