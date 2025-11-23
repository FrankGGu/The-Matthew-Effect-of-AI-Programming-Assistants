var minimumReverseOperations = function(n, p, banned, k) {
    const ans = new Array(n).fill(-1);
    const queue = [];

    // DSU-like structure for finding next unvisited even/odd index
    // nextEven[i] stores the smallest even index j >= i that is not visited
    // nextOdd[i] stores the smallest odd index j >= i that is not visited
    const nextEven = new Array(n + 1).fill(0).map((_, i) => i);
    const nextOdd = new Array(n + 1).fill(0).map((_, i) => i);

    // Helper function for path compression in DSU
    const find = (arr, idx) => {
        if (idx >= n) return n; // Out of bounds
        if (arr[idx] === idx) return idx;
        return arr[idx] = find(arr, arr[idx]);
    };

    // Initialize DSU structures to skip indices with wrong parity
    // For nextEven, odd indices are effectively 'visited' (skipped)
    // For nextOdd, even indices are effectively 'visited' (skipped)
    for (let i = 0; i < n; i++) {
        if (i % 2 !== 0) { // If i is odd, it cannot be found by find(nextEven, i)
            nextEven[i] = find(nextEven, i + 1);
        } else { // If i is even, it cannot be found by find(nextOdd, i)
            nextOdd[i] = find(nextOdd, i + 1);
        }
    }

    // Mark banned positions as visited in the DSU structures
    for (const b of banned) {
        if (b % 2 === 0) {
            nextEven[b] = find(nextEven, b + 1);
        } else {
            nextOdd[b] = find(nextOdd, b + 1);
        }
    }

    // Start BFS from p
    let p_is_banned = false;
    if (p % 2 === 0) {
        if (find(nextEven, p) !== p) p_is_banned = true;
    } else {
        if (find(nextOdd, p) !== p) p_is_banned = true;
    }

    if (!p_is_banned) {
        ans[p] = 0;
        queue.push(p);
        // Mark p as visited in its respective DSU structure
        if (p % 2 === 0) {
            nextEven[p] = find(nextEven, p + 1);
        } else {
            nextOdd[p] = find(nextOdd, p + 1);
        }
    }

    let head = 0;
    while (head < queue.length) {
        const curr = queue[head++];

        // Calculate the range of L for current position curr
        // L is the starting index of the subarray of length k
        // 0 <= L <= n - k
        // L <= curr <= L + k - 1  => curr - k + 1 <= L <= curr
        const L_min = Math.max(0, curr - k + 1);
        const L_max = Math.min(n - k, curr);

        // Calculate the range of reachable positions [y_min_val, y_max_val]
        // New position y = L + (L + k - 1 - curr) = 2L + k - 1 - curr
        const y_min_val = 2 * L_min + k - 1 - curr;
        const y_max_val = 2 * L_max + k - 1 - curr;

        // Determine the parity of reachable nodes
        // y % 2 = (2L + k - 1 - curr) % 2 = (k - 1 - curr) % 2
        // Add 2 and take modulo 2 to handle potential negative results from % in JS
        const targetParity = ((k - 1 - curr) % 2 + 2) % 2; 

        let currentIdxInRange;
        let targetDSU;
        if (targetParity === 0) {
            targetDSU = nextEven;
            currentIdxInRange = find(nextEven, y_min_val);
        } else {
            targetDSU = nextOdd;
            currentIdxInRange = find(nextOdd, y_min_val);
        }

        // Iterate through reachable unvisited nodes in the range with correct parity
        while (currentIdxInRange <= y_max_val) {
            ans[currentIdxInRange] = ans[curr] + 1;
            queue.push(currentIdxInRange);

            // Mark currentIdxInRange as visited and move to the next unvisited node
            // in the DSU structure. Path compression ensures efficiency.
            targetDSU[currentIdxInRange] = find(targetDSU, currentIdxInRange + 1);
            currentIdxInRange = find(targetDSU, currentIdxInRange + 1);
        }
    }

    return ans;
};