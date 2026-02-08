class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    int base = 1000000007;
    long[] powers;
    Set<Long> set = new HashSet<>();

    public int longestCommonSubpath(int n, int[][] paths) {
        int maxLen = 0;
        for (int len = 1; len <= n; len++) {
            if (check(len, paths)) {
                maxLen = len;
            }
        }
        return maxLen;
    }

    private boolean check(int len, int[][] paths) {
        set.clear();
        powers = new long[len];
        long hash = 0;
        long power = 1;

        for (int path[] : paths) {
            hash = 0;
            power = 1;
            for (int i = 0; i < len; i++) {
                hash = (hash * 31 + path[i]) % base;
                powers[i] = power;
                power = (power * 31) % base;
            }
            set.add(hash);
            for (int i = len; i < path.length; i++) {
                hash = (hash * 31 - (path[i - len] * powers[len - 1]) % base + base) % base;
                hash = (hash + path[i]) % base;
                set.add(hash);
            }
        }

        return set.size() > 0;
    }
}