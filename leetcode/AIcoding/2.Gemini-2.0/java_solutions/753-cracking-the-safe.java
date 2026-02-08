import java.util.HashSet;
import java.util.Set;

class Solution {
    public String crackSafe(int n, int k) {
        int total = (int) Math.pow(k, n);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            sb.append('0');
        }
        String start = sb.toString();
        Set<String> visited = new HashSet<>();
        visited.add(start);
        dfs(start, total, n, k, visited, sb);
        return sb.toString();
    }

    private boolean dfs(String node, int total, int n, int k, Set<String> visited, StringBuilder sb) {
        if (visited.size() == total) {
            return true;
        }
        for (int i = 0; i < k; i++) {
            String next = node.substring(1) + i;
            if (!visited.contains(next)) {
                visited.add(next);
                sb.append(i);
                if (dfs(next, total, n, k, visited, sb)) {
                    return true;
                }
                sb.deleteCharAt(sb.length() - 1);
                visited.remove(next);
            }
        }
        return false;
    }
}