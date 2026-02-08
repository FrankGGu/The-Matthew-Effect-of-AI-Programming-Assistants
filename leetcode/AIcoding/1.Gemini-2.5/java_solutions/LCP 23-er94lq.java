import java.util.*;

class Solution {
    List<Integer>[] adj;
    List<Integer> path;
    boolean[] visited;
    int N;

    public List<Integer> magicPermutation(int n) {
        N = n;
        adj = new List[N + 1];
        for (int i = 1; i <= N; i++) {
            adj[i] = new ArrayList<>();
        }

        Set<Integer> perfectSquares = new HashSet<>();
        for (int i = 1; i * i <= 2 * N - 1; i++) { 
            perfectSquares.add(i * i);
        }

        for (int i = 1; i <= N; i++) {
            for (int j = i + 1; j <= N; j++) {
                if (perfectSquares.contains(i + j)) {
                    adj[i].add(j);
                    adj[j].add(i);
                }
            }
        }

        path = new ArrayList<>();
        visited = new boolean[N + 1];

        for (int i = 1; i <= N; i++) {
            path.clear();
            Arrays.fill(visited, false);

            path.add(i);
            visited[i] = true;

            if (dfs(i)) {
                return path;
            }
        }

        return new ArrayList<>();
    }

    private boolean dfs(int currentNum) {
        if (path.size() == N) {
            return true;
        }

        for (int nextNum : adj[currentNum]) {
            if (!visited[nextNum]) {
                visited[nextNum] = true;
                path.add(nextNum);
                if (dfs(nextNum)) {
                    return true;
                }
                path.remove(path.size() - 1);
                visited[nextNum] = false;
            }
        }
        return false;
    }
}