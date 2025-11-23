public class Solution {

import java.util.*;

public class Solution {
    public String crackSafe(int n, int k) {
        if (n == 1 && k == 1) return "0";
        Set<String> visited = new HashSet<>();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            sb.append('0');
        }
        visited.add(sb.toString());
        dfs(n, k, visited, sb);
        return sb.toString();
    }

    private boolean dfs(int n, int k, Set<String> visited, StringBuilder sb) {
        if (visited.size() == Math.pow(k, n)) {
            return true;
        }
        for (int i = 0; i < k; i++) {
            String last = sb.substring(sb.length() - n + 1);
            String next = last + i;
            if (!visited.contains(next)) {
                visited.add(next);
                sb.append(i);
                if (dfs(n, k, visited, sb)) {
                    return true;
                }
                sb.deleteCharAt(sb.length() - 1);
                visited.remove(next);
            }
        }
        return false;
    }
}
}