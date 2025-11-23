var canPartition = function(arr, k) {
    const n = arr.length;

    if (k === 0) {
        return n === 0;
    }
    if (n === 0) {
        return false;
    }
    if (k > n) {
        return false;
    }

    // P[i] stores the largest index j < i-1 such that arr[j] >= arr[j+1].
    // If no such j exists, P[i] is -1.
    // This implies that the subarray arr[p...i-1] is strictly increasing if p > P[i].
    const P = new Array(n + 1).fill(-1);
    for (let i = 2; i <= n; i++) {
        if (arr[i - 2] >= arr[i - 1]) {
            P[i] = i - 2;
        } else {
            P[i] = P[i - 1];
        }
    }

    // dp_prev[i] is true if arr[0...i-1] can be partitioned into j-1 increasing subarrays.
    // dp_curr[i] is true if arr[0...i-1] can be partitioned into j increasing subarrays.
    let dp_prev = new Array(n + 1).fill(false);
    dp_prev[0] = true; // Base case: an empty prefix can be partitioned into 0 subarrays.

    // Segment tree for range OR queries.
    // tree[node] stores the OR of boolean values in its range.
    const tree = new Array(4 * (n + 1)).fill(false);

    // Query function for segment tree.
    // Queries the OR of values in range [l, r].
    function query(node, start, end, l, r) {
        if (r < start || end < l) {
            return false;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        const mid = Math.floor((start + end) / 2);
        const p1 = query(2 * node, start, mid, l, r);
        const p2 = query(2 * node + 1, mid + 1, end, l, r);
        return p1 || p2;
    }

    // Update function for segment tree.
    // Sets the value at idx to val.
    function update(node, start, end, idx, val) {
        if (start === end) {
            tree[node] = val;
        } else {
            const mid = Math.floor((start + end) / 2);
            if (start <= idx && idx <= mid) {
                update(2 * node, start, mid, idx, val);
            } else {
                update(2 * node + 1, mid + 1, end, idx, val);
            }
            tree[node] = tree[2 * node] || tree[2 * node + 1];
        }
    }

    // Iterate through the number of subarrays (j) from 1 to k.
    for (let j = 1; j <= k; j++) {
        let dp_curr = new Array(n + 1).fill(false);

        // Reset and populate the segment tree with dp_prev values (dp[][j-1]).
        // This effectively rebuilds the tree for the current j-1 state.
        for (let t = 0; t < 4 * (n + 1); t++) {
            tree[t] = false;
        }
        for (let p_idx = 0; p_idx <= n; p_idx++) {
            if (dp_prev[p_idx]) {
                update(1, 0, n, p_idx, true);
            }
        }

        // Iterate through array prefixes (i) from 1 to n.
        for (let i = 1; i <= n; i++) {
            // start_p is the smallest index p such that arr[p...i-1] is an increasing subarray.
            // end_p is the largest index p such that arr[p...i-1] is an increasing subarray (p must be < i).
            const start_p = P[i] + 1;
            const end_p = i - 1;

            if (start_p <= end_p) {
                // If there exists any p in [start_p, end_p] such that dp_prev[p] is true,
                // then dp_curr[i] can be true.
                if (query(1, 0, n, start_p, end_p)) {
                    dp_curr[i] = true;
                }
            }
        }
        dp_prev = dp_curr; // Move to the next iteration (j becomes j+1, dp_curr becomes dp_prev).
    }

    return dp_prev[n];
};