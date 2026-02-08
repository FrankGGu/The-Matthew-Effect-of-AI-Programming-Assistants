class Solution {
    int[] parent;
    int[] sz; // Stores the size of the component if 'i' is its root.
    int[] counts; // counts[k] stores the number of groups of size k.

    // Finds the root of the component containing element 'i' with path compression.
    int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    // Merges components of elements 'i' and 'j'.
    // It updates the 'parent', 'sz', and 'counts' arrays.
    // Returns the root of the merged component.
    int union(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);

        if (root_i != root_j) {
            // Union by size/rank: attach the smaller tree under the root of the larger tree.
            // This helps keep the tree flatter.
            if (sz[root_i] < sz[root_j]) {
                int temp = root_i;
                root_i = root_j;
                root_j = temp;
            }

            // Decrement counts for the two old components' sizes.
            counts[sz[root_i]]--;
            counts[sz[root_j]]--;

            // Merge: make root_i the parent of root_j.
            parent[root_j] = root_i;
            // Update the size of the new merged component.
            sz[root_i] += sz[root_j];

            // Increment count for the new merged component's size.
            counts[sz[root_i]]++;
        }
        return root_i; // Return the root of the merged component.
    }

    public int findLatestStep(int[] arr, int m) {
        int n = arr.length;

        // Initialize DSU data structures for 1-indexed elements.
        parent = new int[n + 1];
        sz = new int[n + 1];
        counts = new int[n + 1]; // Max group size can be 'n'.

        // `is_set[k]` is true if the bit at position `k` is set (i.e., `k` has been processed from `arr`).
        boolean[] is_set = new boolean[n + 1]; 

        int ans = -1; // Stores the latest step (1-indexed) where a group of size 'm' existed.

        // Iterate through the steps as bits are set.
        for (int i = 0; i < n; i++) {
            int pos = arr[i]; // The current position to set a bit.

            // Mark the current position as set.
            is_set[pos] = true;

            // Initially, 'pos' forms its own group of size 1.
            parent[pos] = pos; // 'pos' is its own root.
            sz[pos] = 1;       // Group size is 1.
            counts[1]++;       // Increment count for groups of size 1.

            // Check and merge with the left neighbor if it's already set.
            if (pos > 1 && is_set[pos - 1]) {
                union(pos, pos - 1);
            }

            // Check and merge with the right neighbor if it's already set.
            // Note: `pos` might have already merged with its left neighbor,
            // so `find(pos)` would give the root of the combined component.
            if (pos < n && is_set[pos + 1]) {
                union(pos, pos + 1);
            }

            // After all potential merges for the current `pos`,
            // check if there is at least one group of size 'm'.
            if (counts[m] > 0) {
                ans = i + 1; // Update the answer to the current 1-indexed step.
            }
        }
        return ans;
    }
}