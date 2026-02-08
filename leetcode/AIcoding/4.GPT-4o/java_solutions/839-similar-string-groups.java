import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numSimilarGroups(String[] A) {
        int n = A.length;
        boolean[] visited = new boolean[n];
        int groups = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                dfs(A, visited, i);
                groups++;
            }
        }

        return groups;
    }

    private void dfs(String[] A, boolean[] visited, int index) {
        visited[index] = true;
        for (int i = 0; i < A.length; i++) {
            if (!visited[i] && isSimilar(A[index], A[i])) {
                dfs(A, visited, i);
            }
        }
    }

    private boolean isSimilar(String a, String b) {
        int diff = 0;
        for (int i = 0; i < a.length(); i++) {
            if (a.charAt(i) != b.charAt(i)) {
                diff++;
                if (diff > 2) return false;
            }
        }
        return diff == 0 || diff == 2;
    }
}