import java.util.*;

public class Solution {
    public String crackSafe(int n, int k) {
        StringBuilder result = new StringBuilder();
        Set<String> visited = new HashSet<>();
        String start = "0".repeat(n);
        dfs(start, n, k, visited, result);
        result.append(start);
        return result.toString();
    }

    private void dfs(String node, int n, int k, Set<String> visited, StringBuilder result) {
        for (int i = 0; i < k; i++) {
            String next = node + i;
            String edge = next.substring(next.length() - n);
            if (!visited.contains(edge)) {
                visited.add(edge);
                dfs(edge, n, k, visited, result);
                result.append(i);
            }
        }
    }
}