public class Solution {

import java.util.*;

public class Solution {
    public String crackSafe(int n, int k) {
        StringBuilder sb = new StringBuilder();
        Set<String> visited = new HashSet<>();
        String start = String.format("%0" + n + "d", 0);
        dfs(n, k, start, visited, sb);
        return sb.toString();
    }

    private void dfs(int n, int k, String node, Set<String> visited, StringBuilder sb) {
        for (int i = 0; i < k; i++) {
            String next = node + i;
            String suffix = next.substring(1);
            if (!visited.contains(suffix)) {
                visited.add(suffix);
                sb.append(i);
                dfs(n, k, suffix, visited, sb);
            }
        }
    }
}
}