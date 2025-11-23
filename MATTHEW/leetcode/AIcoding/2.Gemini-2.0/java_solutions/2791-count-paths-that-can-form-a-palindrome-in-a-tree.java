import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Solution {
    public int countPalindromePaths(int[] parent, String s) {
        int n = parent.length;
        List<Integer>[] adj = new List[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new java.util.ArrayList<>();
        }
        for (int i = 0; i < n; i++) {
            if (parent[i] != -1) {
                adj[parent[i]].add(i);
                adj[i].add(parent[i]);
            }
        }

        int[] charValues = new int[n];
        for (int i = 0; i < n; i++) {
            charValues[i] = 1 << (s.charAt(i) - 'a');
        }

        Map<Integer, Integer> count = new HashMap<>();
        count.put(0, 1);

        int result = 0;

        java.util.Stack<int[]> stack = new java.util.Stack<>();
        stack.push(new int[]{0, -1, 0});

        while (!stack.isEmpty()) {
            int[] curr = stack.pop();
            int node = curr[0];
            int par = curr[1];
            int pathMask = curr[2] ^ charValues[node];

            result += count.getOrDefault(pathMask, 0);
            for (int i = 0; i < 26; i++) {
                result += count.getOrDefault(pathMask ^ (1 << i), 0);
            }

            count.put(pathMask, count.getOrDefault(pathMask, 0) + 1);

            for (int neighbor : adj[node]) {
                if (neighbor != par) {
                    stack.push(new int[]{neighbor, node, pathMask});
                }
            }
        }

        count.clear();
        count.put(0, 1);
        stack.push(new int[]{0, -1, 0});
        while (!stack.isEmpty()) {
            int[] curr = stack.pop();
            int node = curr[0];
            int par = curr[1];
            int pathMask = curr[2] ^ charValues[node];

            for (int neighbor : adj[node]) {
                if (neighbor != par) {
                    stack.push(new int[]{neighbor, node, pathMask});
                }
            }
            count.put(pathMask, count.getOrDefault(pathMask, 0) + 1);
        }

        count.clear();

        stack.push(new int[]{0, -1, 0});
        while (!stack.isEmpty()) {
            int[] curr = stack.pop();
            int node = curr[0];
            int par = curr[1];
            int pathMask = curr[2] ^ charValues[node];
            count.put(pathMask, count.getOrDefault(pathMask, 0) -1);

            for (int neighbor : adj[node]) {
                if (neighbor != par) {
                    stack.push(new int[]{neighbor, node, pathMask});
                }
            }

        }

        stack.push(new int[]{0, -1, 0});
        while (!stack.isEmpty()) {
            int[] curr = stack.pop();
            int node = curr[0];
            int par = curr[1];
            int pathMask = curr[2] ^ charValues[node];

            result -= count.getOrDefault(pathMask, 0);
            for (int i = 0; i < 26; i++) {
                result -= count.getOrDefault(pathMask ^ (1 << i), 0);
            }

            for (int neighbor : adj[node]) {
                if (neighbor != par) {
                    stack.push(new int[]{neighbor, node, pathMask});
                }
            }
        }

        return result / 2;
    }
}