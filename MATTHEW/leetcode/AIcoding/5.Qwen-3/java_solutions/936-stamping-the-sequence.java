public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> movesToStamp(String stamp, String target) {
        int m = stamp.length();
        int n = target.length();
        boolean[] visited = new boolean[n];
        List<Integer> result = new ArrayList<>();
        int count = 0;

        while (count < n) {
            boolean found = false;
            for (int i = 0; i <= n - m; i++) {
                if (!visited[i] && canReplace(target, stamp, i)) {
                    found = true;
                    count += m;
                    visited[i] = true;
                    result.add(i);
                    for (int j = 0; j < m; j++) {
                        visited[i + j] = true;
                    }
                    break;
                }
            }
            if (!found) {
                return new ArrayList<>();
            }
        }

        Collections.reverse(result);
        return result;
    }

    private boolean canReplace(String target, String stamp, int start) {
        for (int i = 0; i < stamp.length(); i++) {
            if (target.charAt(start + i) != stamp.charAt(i)) {
                return false;
            }
        }
        return true;
    }
}
}