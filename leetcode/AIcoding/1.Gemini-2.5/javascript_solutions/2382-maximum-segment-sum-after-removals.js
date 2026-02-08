var maximumSegmentSum = function(nums, removals) {
    const n = nums.length;
    const ans = new Array(n);

    // DSU data structures
    const parent = new Array(n);
    const sum = new Array(n);
    // Tracks which elements are currently "present" in our reversed process
    const present = new Array(n).fill(false);

    // Initialize DSU for elements that will be added back
    // Initially, each element is its own parent and its sum is its own value.
    for (let i = 0; i < n; i++) {
        parent[i] = i;
        sum[i] = nums[i];
    }

    let currentMaxSum = 0;

    // Helper function for find (with path compression)
    const find = (i) => {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    };

    // Helper function for union
    // Merges the segment containing j into the segment containing i
    const union = (i, j) => {
        let rootI = find(i);
        let rootJ = find(j);

        if (rootI !== rootJ) {
            // Merge rootJ's tree into rootI's tree
            parent[rootJ] = rootI;
            sum[rootI] += sum[rootJ];
            // Update the global maximum segment sum with the sum of the newly merged segment
            currentMaxSum = Math.max(currentMaxSum, sum[rootI]);
        }
    };

    // Process removals in reverse order
    // k goes from n-1 down to 0
    // ans[k] corresponds to the state *after* removals[k] has been performed.
    // In our reverse process, this is the state *before* removals[k] is added back.
    for (let k = n - 1; k >= 0; k--) {
        // Store the current maximum segment sum for the state where removals[k] (and earlier removals) are removed.
        ans[k] = currentMaxSum;

        const idx = removals[k];
        present[idx] = true; // Mark the element as present

        // Update currentMaxSum with the value of the newly added element itself
        // (in case it forms an isolated segment and is the new max)
        currentMaxSum = Math.max(currentMaxSum, nums[idx]);

        // Check and union with left neighbor
        if (idx > 0 && present[idx - 1]) {
            union(idx, idx - 1);
        }

        // Check and union with right neighbor
        if (idx < n - 1 && present[idx + 1]) {
            union(idx, idx + 1);
        }
    }

    return ans;
};