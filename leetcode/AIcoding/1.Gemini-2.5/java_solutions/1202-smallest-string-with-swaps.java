import java.util.*;

class Solution {
    private int[] parent;

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    private void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);
        if (rootI != rootJ) {
            parent[rootI] = rootJ;
        }
    }

    public String smallestStringWithSwaps(String s, List<List<Integer>> pairs) {
        int n = s.length();
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        for (List<Integer> pair : pairs) {
            union(pair.get(0), pair.get(1));
        }

        Map<Integer, List<Integer>> indicesMap = new HashMap<>();
        Map<Integer, List<Character>> charsMap = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int root = find(i);
            indicesMap.computeIfAbsent(root, k -> new ArrayList<>()).add(i);
            charsMap.computeIfAbsent(root, k -> new ArrayList<>()).add(s.charAt(i));
        }

        char[] result = new char[n];
        for (int root : indicesMap.keySet()) {
            List<Integer> currentIndices = indicesMap.get(root);
            List<Character> currentChars = charsMap.get(root);

            Collections.sort(currentIndices);
            Collections.sort(currentChars);

            for (int i = 0; i < currentIndices.size(); i++) {
                result[currentIndices.get(i)] = currentChars.get(i);
            }
        }

        return new String(result);
    }
}