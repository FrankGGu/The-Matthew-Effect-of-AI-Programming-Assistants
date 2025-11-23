import java.util.HashMap;
import java.util.Map;

class Solution {

    class DSU {
        int[] parent;
        int[] size; // Stores the count of original strings for each mask in the component

        DSU(int n) {
            parent = new int[n];
            size = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);
            if (rootI != rootJ) {
                parent[rootJ] = rootI;
                size[rootI] += size[rootJ];
            }
        }
    }

    public int[] groupsOfStrings(String[] words) {
        Map<Integer, Integer> maskToCount = new HashMap<>();
        for (String word : words) {
            int mask = 0;
            for (char c : word.toCharArray()) {
                mask |= (1 << (c - 'a'));
            }
            maskToCount.put(mask, maskToCount.getOrDefault(mask, 0) + 1);
        }

        Map<Integer, Integer> maskToIndex = new HashMap<>();
        int index = 0;
        for (int mask : maskToCount.keySet()) {
            maskToIndex.put(mask, index++);
        }

        int numUniqueMasks = maskToCount.size();
        DSU dsu = new DSU(numUniqueMasks);

        for (Map.Entry<Integer, Integer> entry : maskToCount.entrySet()) {
            int mask = entry.getKey();
            int count = entry.getValue();
            dsu.size[maskToIndex.get(mask)] = count;
        }

        for (int mask1 : maskToCount.keySet()) {
            int idx1 = maskToIndex.get(mask1);

            // Case 1: Adding or Deleting one character
            // mask2 is formed by toggling one bit in mask1
            for (int i = 0; i < 26; i++) {
                int mask2 = mask1 ^ (1 << i);
                if (maskToCount.containsKey(mask2)) {
                    int idx2 = maskToIndex.get(mask2);
                    dsu.union(idx1, idx2);
                }
            }

            // Case 2: Replacing one character
            // This means deleting one character and adding another.
            // Iterate through characters present in mask1 (to delete)
            for (int i = 0; i < 26; i++) {
                if ((mask1 & (1 << i)) != 0) { // If i-th char is present in mask1
                    int maskAfterDelete = mask1 ^ (1 << i); // Remove i-th char
                    // Iterate through characters NOT present in maskAfterDelete (to add)
                    for (int j = 0; j < 26; j++) {
                        if ((maskAfterDelete & (1 << j)) == 0) { // If j-th char is NOT present
                            int mask2 = maskAfterDelete | (1 << j); // Add j-th char
                            if (maskToCount.containsKey(mask2)) {
                                int idx2 = maskToIndex.get(mask2);
                                dsu.union(idx1, idx2);
                            }
                        }
                    }
                }
            }
        }

        int numGroups = 0;
        int maxGroupSize = 0;
        for (int i = 0; i < numUniqueMasks; i++) {
            if (dsu.parent[i] == i) { // If i is a root
                numGroups++;
                maxGroupSize = Math.max(maxGroupSize, dsu.size[i]);
            }
        }

        return new int[]{numGroups, maxGroupSize};
    }
}