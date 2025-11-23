import java.util.*;

class Solution {
    int maxPath = 0;
    List<List<Integer>> adj;
    String s;

    public int longestPath(int[] parent, String s) {
        this.s = s;
        int n = parent.length;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 1; i < n; i++) {
            adj.get(parent[i]).add(i);
        }

        maxPath = 1; 
        dfs(0);
        return maxPath;
    }

    private int dfs(int u) {
        int longestPathFromU = 1; 

        List<Integer> childPathLengths = new ArrayList<>();

        for (int v : adj.get(u)) {
            int pathFromChild = dfs(v);
            if (s.charAt(u) != s.charAt(v)) {
                childPathLengths.add(pathFromChild);
            }
        }

        Collections.sort(childPathLengths, Collections.reverseOrder());

        int currentPathThroughU = 1; 

        if (!childPathLengths.isEmpty()) {
            longestPathFromU = 1 + childPathLengths.get(0);
            currentPathThroughU += childPathLengths.get(0);
        }

        if (childPathLengths.size() >= 2) {
            currentPathThroughU += childPathLengths.get(1);
        }

        maxPath = Math.max(maxPath, currentPathThroughU);

        return longestPathFromU;
    }
}