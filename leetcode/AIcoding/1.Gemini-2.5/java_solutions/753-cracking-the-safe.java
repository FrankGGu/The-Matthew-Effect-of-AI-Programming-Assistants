import java.util.HashSet;
import java.util.Set;

class Solution {
    StringBuilder ans;
    Set<String> visited;
    int N;
    int K;

    public String crackSafe(int n, int k) {
        N = n;
        K = k;
        ans = new StringBuilder();
        visited = new HashSet<>();

        StringBuilder initialPrefix = new StringBuilder();
        for (int i = 0; i < N - 1; i++) {
            initialPrefix.append('0');
        }

        dfs(initialPrefix.toString());

        ans.append(initialPrefix); // Append the initial prefix to the end for the final string

        return ans.toString();
    }

    private void dfs(String node) {
        for (int i = K - 1; i >= 0; i--) {
            String neighborDigit = String.valueOf(i);
            String newPassword = node + neighborDigit;

            if (!visited.contains(newPassword)) {
                visited.add(newPassword);
                ans.append(neighborDigit);

                dfs(newPassword.substring(1));
            }
        }
    }
}