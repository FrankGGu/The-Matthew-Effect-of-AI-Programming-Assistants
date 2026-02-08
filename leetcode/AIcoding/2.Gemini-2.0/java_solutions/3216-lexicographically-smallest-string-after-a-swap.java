import java.util.*;

class Solution {
    public String smallestStringWithSwaps(String s, List<List<Integer>> pairs) {
        int n = s.length();
        List<Integer>[] adj = new List[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        for (List<Integer> pair : pairs) {
            int u = pair.get(0);
            int v = pair.get(1);
            adj[u].add(v);
            adj[v].add(u);
        }

        boolean[] visited = new boolean[n];
        char[] result = s.toCharArray();

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                List<Integer> indices = new ArrayList<>();
                List<Character> chars = new ArrayList<>();
                dfs(i, adj, visited, indices, chars, s);

                Collections.sort(indices);
                Collections.sort(chars);

                for (int j = 0; j < indices.size(); j++) {
                    result[indices.get(j)] = chars.get(j);
                }
            }
        }

        return new String(result);
    }

    private void dfs(int u, List<Integer>[] adj, boolean[] visited, List<Integer> indices, List<Character> chars, String s) {
        visited[u] = true;
        indices.add(u);
        chars.add(s.charAt(u));

        for (int v : adj[u]) {
            if (!visited[v]) {
                dfs(v, adj, visited, indices, chars, s);
            }
        }
    }
}