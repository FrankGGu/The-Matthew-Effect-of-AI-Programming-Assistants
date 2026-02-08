public class Solution {
    public String getHappyString(int n, int k) {
        StringBuilder result = new StringBuilder();
        boolean[] used = new boolean[26];
        char[] chars = {'a', 'b', 'c'};

        return dfs(n, k, 0, result, used, chars);
    }

    private String dfs(int n, int k, int depth, StringBuilder result, boolean[] used, char[] chars) {
        if (depth == n) {
            return result.toString();
        }

        for (int i = 0; i < 3; i++) {
            if (used[i]) continue;
            if (depth > 0 && result.charAt(depth - 1) == chars[i]) continue;

            used[i] = true;
            result.append(chars[i]);
            String res = dfs(n, k, depth + 1, result, used, chars);
            if (res != null) return res;
            result.deleteCharAt(result.length() - 1);
            used[i] = false;
        }

        return null;
    }
}