import java.util.*;

class Solution {
    public int[] groupStrings(String[] words) {
        int n = words.length;
        int[] parent = new int[n];
        int[] size = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            size[i] = 1;
        }

        Map<Integer, Integer> maskToIndex = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int mask = 0;
            for (char c : words[i].toCharArray()) {
                mask |= (1 << (c - 'a'));
            }
            if (maskToIndex.containsKey(mask)) {
                union(parent, size, i, maskToIndex.get(mask));
            } else {
                maskToIndex.put(mask, i);
            }
        }

        for (int i = 0; i < n; i++) {
            int mask = 0;
            for (char c : words[i].toCharArray()) {
                mask |= (1 << (c - 'a'));
            }

            for (int j = 0; j < 26; j++) {
                int newMask = mask ^ (1 << j);
                if (maskToIndex.containsKey(newMask)) {
                    union(parent, size, i, maskToIndex.get(newMask));
                }
            }

            for (int j = 0; j < 26; j++) {
                if ((mask & (1 << j)) > 0) {
                    int newMask = mask ^ (1 << j);
                    for (int k = 0; k < 26; k++) {
                        if ((newMask & (1 << k)) == 0) {
                            int finalMask = newMask | (1 << k);
                            if (maskToIndex.containsKey(finalMask)) {
                                union(parent, size, i, maskToIndex.get(finalMask));
                            }
                        }
                    }
                }
            }
        }

        int groups = 0;
        int maxSize = 0;
        Set<Integer> visited = new HashSet<>();
        for (int i = 0; i < n; i++) {
            int root = find(parent, i);
            if (!visited.contains(root)) {
                groups++;
                maxSize = Math.max(maxSize, size[root]);
                visited.add(root);
            }
        }

        return new int[]{groups, maxSize};
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    private void union(int[] parent, int[] size, int i, int j) {
        int rootI = find(parent, i);
        int rootJ = find(parent, j);
        if (rootI != rootJ) {
            if (size[rootI] < size[rootJ]) {
                parent[rootI] = rootJ;
                size[rootJ] += size[rootI];
            } else {
                parent[rootJ] = rootI;
                size[rootI] += size[rootJ];
            }
        }
    }
}