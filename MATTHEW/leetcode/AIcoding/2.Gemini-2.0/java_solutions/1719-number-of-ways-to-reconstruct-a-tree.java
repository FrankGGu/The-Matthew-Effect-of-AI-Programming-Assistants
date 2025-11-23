import java.util.*;

class Solution {
    public int checkWays(int[][] pairs) {
        Map<Integer, Set<Integer>> adj = new HashMap<>();
        Set<Integer> nodes = new HashSet<>();
        for (int[] pair : pairs) {
            int u = pair[0], v = pair[1];
            adj.computeIfAbsent(u, k -> new HashSet<>()).add(v);
            adj.computeIfAbsent(v, k -> new HashSet<>()).add(u);
            nodes.add(u);
            nodes.add(v);
        }

        int root = -1;
        for (int node : nodes) {
            if (adj.getOrDefault(node, Collections.emptySet()).size() == nodes.size() - 1) {
                root = node;
                break;
            }
        }

        if (root == -1) {
            return 0;
        }

        Map<Integer, Integer> parent = new HashMap<>();
        parent.put(root, 0);

        for (int node : nodes) {
            if (node != root) {
                int candidate = -1;
                int minDegree = Integer.MAX_VALUE;
                for (int neighbor : adj.get(node)) {
                    if (neighbor != node && adj.get(neighbor).size() < minDegree) {
                        minDegree = adj.get(neighbor).size();
                        candidate = neighbor;
                    }
                }

                if (candidate == -1) return 0;

                boolean found = false;
                for (int neighbor : adj.get(node)) {
                    if (adj.get(candidate).contains(neighbor)) {
                        found = true;
                    } else if (neighbor != candidate && neighbor != node) {
                        return 0;
                    }
                }
                if (!adj.get(candidate).contains(node)) return 0;

                parent.put(node, candidate);
            }
        }

        int count = 1;
        for(int node : nodes){
            if(node != root && adj.get(parent.get(node)).size() == adj.get(node).size()){
                count = 2;
                break;
            }
        }

        Set<Integer> visited = new HashSet<>();
        visited.add(root);
        for(int node : nodes){
            if(!dfs(node, adj, visited, parent)) return 0;
        }

        if(visited.size() != nodes.size()) return 0;

        return count;
    }

    private boolean dfs(int node, Map<Integer, Set<Integer>> adj, Set<Integer> visited, Map<Integer, Integer> parent){
        if(visited.contains(node)) return true;

        if(parent.containsKey(node) && !visited.contains(parent.get(node))){
            return false;
        }

        visited.add(node);
        return true;
    }
}