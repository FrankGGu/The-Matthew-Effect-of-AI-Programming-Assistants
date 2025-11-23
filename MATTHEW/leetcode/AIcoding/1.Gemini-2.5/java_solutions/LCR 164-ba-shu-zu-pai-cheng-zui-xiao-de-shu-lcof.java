import java.util.HashSet;
import java.util.Set;
import java.lang.StringBuilder;

class Solution {
    int N;
    int K;
    Set<String> visited;
    StringBuilder result;

    public String crackSafe(int n, int k) {
        N = n;
        K = k;
        visited = new HashSet<>();
        result = new StringBuilder();

        StringBuilder initialPrefix = new StringBuilder();
        for (int i = 0; i < N - 1; i++) {
            initialPrefix.append('0');
        }

        result.append(initialPrefix);

        dfs(initialPrefix.toString());

        return result.toString();
    }

    private void dfs(String currentPrefix) {
        for (int i = K - 1; i >= 0; i--) {
            String nextPassword = currentPrefix + i;
            if (!visited.contains(nextPassword)) {
                visited.add(nextPassword);
                result.append(i);
                dfs(nextPassword.substring(1));
                return;
            }
        }
    }
}