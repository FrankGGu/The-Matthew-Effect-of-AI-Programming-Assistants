import java.util.*;

class Solution {
    public String crackSafe(int n, int k) {
        if (n == 1 && k == 1) {
            return "0";
        }

        int total = (int) Math.pow(k, n);
        StringBuilder sb = new StringBuilder();
        Set<String> visited = new HashSet<>();

        String start = "0".repeat(n - 1);
        sb.append(start);

        for (int i = 0; i < total; i++) {
            for (int j = k - 1; j >= 0; j--) {
                String next = sb.substring(sb.length() - (n - 1)) + j;
                if (!visited.contains(next)) {
                    sb.append(j);
                    visited.add(next);
                    break;
                }
            }
        }

        return sb.toString();
    }
}